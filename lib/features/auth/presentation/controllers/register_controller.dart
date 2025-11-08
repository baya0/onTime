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

class RegisterController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Phone number from intl_phone_number_input
  final Rxn<PhoneNumber> phoneNumber = Rxn<PhoneNumber>();
  final phoneNumberString = ''.obs;

  // Focus nodes
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Observable states
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final agreeToTerms = false.obs;

  // City selection
  final cities = <Map<String, dynamic>>[].obs;
  final isLoadingCities = false.obs;
  final Rxn<int> selectedCityId = Rxn<int>();
  final Rxn<String> selectedCityName = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    loadCities();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    cityFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  /// Called when phone number changes
  void onPhoneNumberChanged(PhoneNumber number) {
    phoneNumber.value = number;
    phoneNumberString.value = number.phoneNumber ?? '';
    debugPrint('📱 Phone changed: ${number.phoneNumber}');
  }

  Future<void> loadCities() async {
    try {
      isLoadingCities.value = true;
      final response = await _apiService.getCities();

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List;
        cities.value = data.map((city) => city as Map<String, dynamic>).toList();
        debugPrint('✅ Loaded ${cities.length} cities');
      }
    } catch (e) {
      debugPrint('❌ Error loading cities: $e');
      _showError(tr(LocaleKeys.failed_to_load_cities));
    } finally {
      isLoadingCities.value = false;
    }
  }

  void selectCity(int cityId, String cityName) {
    selectedCityId.value = cityId;
    selectedCityName.value = cityName;
    debugPrint('📍 Selected city: $cityName (ID: $cityId)');
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

  Future<void> register() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      debugPrint('❌ Form validation failed');
      return;
    }

    // Check phone number
    if (phoneNumber.value == null) {
      _showError(tr(LocaleKeys.phone_required));
      return;
    }

    // Check city selection
    if (selectedCityId.value == null) {
      _showError(tr(LocaleKeys.city_required));
      return;
    }

    // Check terms agreement
    if (!agreeToTerms.value) {
      _showError(tr(LocaleKeys.must_agree_to_terms));
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Starting registration...');

      // Format phone number for API
      final formattedPhone = _formatPhoneForAPI(phoneNumber.value!);
      debugPrint('📱 Phone formatted for API: $formattedPhone');

      final response = await _apiService.register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phone: formattedPhone,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        cityId: selectedCityId.value!,
      );

      debugPrint('📡 Register response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = data['user'];

        // Store user data
        _storageService.write('user_id', user['id']);
        _storageService.write('first_name', user['first_name']);
        _storageService.write('last_name', user['last_name']);
        _storageService.write('phone', user['phone']);
        _storageService.write('city_id', user['city_id']);

        debugPrint('✅ Registration successful');

        Get.snackbar(
          tr(LocaleKeys.success),
          tr(LocaleKeys.register_success),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: const EdgeInsets.all(16),
        );

        // Navigate to verify page (registration requires verification)
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.verify);
      } else {
        final message = response.data['message'] ?? tr(LocaleKeys.registration_failed);
        _showError(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Registration DioException: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response != null) {
        final message = e.response?.data['message'] ?? tr(LocaleKeys.registration_failed);
        _showError(message);
      } else {
        _showError(tr(LocaleKeys.network_error));
      }
    } catch (e) {
      debugPrint('❌ Unexpected registration error: $e');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // VALIDATORS
  // ============================================================

  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.first_name_required);
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.last_name_required);
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.phone_required);
    }

    if (phoneNumber.value == null) {
      return tr(LocaleKeys.invalid_phone);
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.password_required);
    }
    if (value.length < 8) {
      return tr(LocaleKeys.password_too_short);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    if (value != passwordController.text) {
      return tr(LocaleKeys.passwords_dont_match);
    }
    return null;
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

  void goToLogin() {
    Get.back();
  }
}
