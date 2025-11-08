import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/style/app_colors.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Phone number from intl_phone_number_input
  final Rxn<PhoneNumber> phoneNumber = Rxn<PhoneNumber>();
  final phoneNumberString = ''.obs;

  // Text controllers
  final passwordController = TextEditingController();

  // Focus nodes
  final passwordFocusNode = FocusNode();

  // Observable states
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  @override
  void onClose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void _loadSavedCredentials() {
    // Load saved phone if remember me was checked
    final savedPhone = _storageService.read('saved_phone');
    final savedRememberMe = _storageService.read('remember_me') ?? false;

    if (savedRememberMe && savedPhone != null) {
      phoneNumberString.value = savedPhone;
      rememberMe.value = true;
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// Called when phone number changes
  void onPhoneNumberChanged(PhoneNumber number) {
    phoneNumber.value = number;
    phoneNumberString.value = number.phoneNumber ?? '';
    debugPrint('📱 Phone changed: ${number.phoneNumber}');
  }

  /// Validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.phone_required);
    }

    if (phoneNumber.value == null) {
      return tr(LocaleKeys.invalid_phone);
    }

    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.password_required);
    }
    if (value.length < 8) {
      return tr(LocaleKeys.password_too_short);
    }
    return null;
  }

  /// Format phone for API - converts to 09XXXXXXXX format
  String _formatPhoneForAPI(PhoneNumber phone) {
    // For Syrian numbers, API expects: 09XXXXXXXX
    if (phone.dialCode == '+963') {
      // Get the national number without country code
      String nationalNumber = phone.parseNumber();

      // Remove +963 and any spaces
      nationalNumber = nationalNumber.replaceAll('+963', '').replaceAll(' ', '').trim();

      // Add leading 0 if not present
      if (!nationalNumber.startsWith('0')) {
        nationalNumber = '0$nationalNumber';
      }

      return nationalNumber;
    }

    // For other countries, return as is
    return phone.phoneNumber ?? '';
  }

  /// Login function with API integration
  Future<void> login() async {
    // Validate form first
    if (!formKey.currentState!.validate()) {
      debugPrint('❌ Form validation failed');
      return;
    }

    // Check phone number
    if (phoneNumber.value == null) {
      _showError(tr(LocaleKeys.phone_required));
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Starting login...');

      // Format phone number for API
      final formattedPhone = _formatPhoneForAPI(phoneNumber.value!);
      debugPrint('📱 Phone formatted for API: $formattedPhone');

      final response = await _apiService.login(
        phone: formattedPhone,
        password: passwordController.text,
      );

      debugPrint('📡 Login response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = data['user'];
        final token = data['token'];
        final isVerified = data['verify'] ?? false;

        // Store user data
        _storageService.write('user_id', user['id']);
        _storageService.write('first_name', user['first_name']);
        _storageService.write('last_name', user['last_name']);
        _storageService.write('phone', user['phone']);
        _storageService.write('city_id', user['city_id']);
        _storageService.write('token', token);
        _storageService.write('is_verified', isVerified);

        // Set token in API service for future requests
        _apiService.setToken(token);

        // Save phone if remember me is checked
        if (rememberMe.value) {
          _storageService.write('saved_phone', formattedPhone);
          _storageService.write('remember_me', true);
        } else {
          _storageService.remove('saved_phone');
          _storageService.write('remember_me', false);
        }

        debugPrint('✅ Login successful. Verified: $isVerified');

        Get.snackbar(
          tr(LocaleKeys.success),
          tr(LocaleKeys.login_success),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        );

        // Navigate based on verification status
        await Future.delayed(const Duration(seconds: 1));

        if (isVerified) {
          // Account is verified, go to home
          // TODO: Uncomment when home page is ready
          // Get.offAllNamed(Routes.home);

          // For now, show a message
          Get.snackbar(
            tr(LocaleKeys.success),
            'Account verified! Navigate to home page.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.green500.withOpacity(0.1),
            colorText: AppColors.green900,
            margin: const EdgeInsets.all(16),
          );
        } else {
          // Account not verified, go to verify page
          Get.offAllNamed(Routes.verify);
        }
      } else {
        final message = response.data['message'] ?? tr(LocaleKeys.invalid_credentials);
        _showError(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Login DioException: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response != null) {
        final message = e.response?.data['message'] ?? tr(LocaleKeys.invalid_credentials);
        _showError(message);
      } else {
        _showError(tr(LocaleKeys.network_error));
      }
    } catch (e) {
      debugPrint('❌ Unexpected login error: $e');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    Get.snackbar(
      tr(LocaleKeys.error),
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withOpacity(0.1),
      colorText: AppColors.error,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  void goToForgotPassword() {
    // TODO: Navigate to forgot password page
    Get.snackbar(
      'Info',
      'Forgot password feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void goToRegister() {
    Get.toNamed(Routes.register);
  }

  void continueAsGuest() {
    // TODO: Navigate to home as guest
    Get.snackbar('Info', 'Guest mode coming soon', snackPosition: SnackPosition.BOTTOM);
  }

  void becomeProvider() {
    // TODO: Navigate to provider registration
    Get.snackbar('Info', 'Provider registration coming soon', snackPosition: SnackPosition.BOTTOM);
  }
}
