import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/style/app_colors.dart';

class VerifyController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // OTP controller for pinput
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  // Phone number data
  String? fullPhoneNumber;
  String? cleanPhone; // For API (e.g., "0965237801")
  String? dialCode; // For API (e.g., "+963")

  // Flags
  bool fromRegistration = false;
  bool fromForgotPassword = false;

  // Observable states
  final isLoading = false.obs;
  final resendCooldown = 0.obs;
  final canResend = true.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    _setupPhoneNumberFromArguments();
    _startResendTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    otpFocusNode.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }

  /// Setup phone number from navigation arguments
  void _setupPhoneNumberFromArguments() {
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;

      fullPhoneNumber = args['phoneNumber'] as String?;
      cleanPhone = args['cleanPhone'] as String?;
      dialCode = args['dialCode'] as String?;
      fromRegistration = args['fromRegistration'] == true;
      fromForgotPassword = args['fromForgotPassword'] == true;

      debugPrint('📱 Verify setup:');
      debugPrint('   Full phone: $fullPhoneNumber');
      debugPrint('   Clean phone: $cleanPhone');
      debugPrint('   Dial code: $dialCode');
      debugPrint('   From registration: $fromRegistration');
      debugPrint('   From forgot password: $fromForgotPassword');
    } else {
      // Fallback: Try to get from storage
      cleanPhone = _storageService.read('phone');
      debugPrint('⚠️ No arguments, using storage phone: $cleanPhone');
    }
  }

  /// Start 60-second cooldown timer for resend
  void _startResendTimer() {
    resendCooldown.value = 60;
    canResend.value = false;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown.value > 0) {
        resendCooldown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Validate OTP (4 digits)
  String? validateOTP(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    if (value.length != 4) {
      return 'Code must be 4 digits';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return tr(LocaleKeys.invalid_code);
    }
    return null;
  }

  /// Verify OTP code
  Future<void> verifyCode() async {
    // Validate
    final validation = validateOTP(otpController.text);
    if (validation != null) {
      _showError(validation);
      return;
    }

    // Check if we have phone number
    if (cleanPhone == null) {
      _showError('Phone number not found. Please try again.');
      Get.offAllNamed(Routes.login);
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Starting verification...');
      debugPrint('   Phone: $cleanPhone');
      debugPrint('   Code: ${otpController.text}');

      final code = int.parse(otpController.text.trim());

      final response = await _apiService.verifyCode(
        phone: cleanPhone!,
        code: code,
        forVerifyAccount: !fromForgotPassword, // 1 for account, 0 for forgot password
      );

      debugPrint('📡 Verify response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        await _handleSuccessfulVerification(response);
      } else {
        final message = response.data['message'] ?? 'Verification failed';
        _showError(message);
        _clearOTP();
      }
    } on DioException catch (e) {
      debugPrint('❌ Verify error: ${e.message}');

      if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Invalid code';
        _showError(message);
      } else {
        _showError(tr(LocaleKeys.network_error));
      }
      _clearOTP();
    } catch (e) {
      debugPrint('❌ Unexpected verify error: $e');
      _showError('Verification failed. Please try again.');
      _clearOTP();
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle successful verification
  Future<void> _handleSuccessfulVerification(response) async {
    final data = response.data['data'];

    if (fromForgotPassword) {
      // Handle forgot password flow
      final resetToken = data['token'];

      Get.snackbar(
        tr(LocaleKeys.success),
        'Phone verified! Set your new password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green500.withOpacity(0.1),
        colorText: AppColors.green900,
      );

      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to reset password page
      Get.offAllNamed(
        Routes.resetPassword,
        arguments: {'resetToken': resetToken, 'phone': cleanPhone},
      );
    } else {
      // Handle registration/login verification
      final user = data['user'];

      // Update storage
      _storageService.write('is_verified', true);
      _storageService.write('user_id', user['id']);

      Get.snackbar(
        tr(LocaleKeys.success),
        'Phone verified successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green500.withOpacity(0.1),
        colorText: AppColors.green900,
      );

      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to home
      // TODO: Uncomment when home is ready
      // Get.offAllNamed(Routes.home);

      // For now, show success message
      Get.snackbar(
        tr(LocaleKeys.success),
        'Navigate to home page',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green500.withOpacity(0.1),
        colorText: AppColors.green900,
      );
    }
  }

  /// Resend verification code
  Future<void> resendCode() async {
    if (!canResend.value) {
      Get.snackbar(
        'Wait',
        'Please wait ${resendCooldown.value} seconds',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (cleanPhone == null) {
      _showError('Phone number not found');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Resending code to: $cleanPhone');

      final response = await _apiService.resendCode(phone: cleanPhone!);

      debugPrint('📡 Resend response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar(
          tr(LocaleKeys.success),
          tr(LocaleKeys.code_resent),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
        );

        _clearOTP();
        _startResendTimer();
      } else {
        _showError('Failed to resend code');
      }
    } on DioException catch (e) {
      debugPrint('❌ Resend error: ${e.message}');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isLoading.value = false;
    }
  }

  void _clearOTP() {
    otpController.clear();
    otpFocusNode.requestFocus();
  }

  void _showError(String message) {
    Get.snackbar(
      tr(LocaleKeys.error),
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withValues(alpha: 0.1),
      colorText: AppColors.error,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  void goBack() {
    Get.back();
  }
}
