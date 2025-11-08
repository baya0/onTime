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

  // OTP controllers - 4 digit code
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  // Focus nodes for OTP fields
  final List<FocusNode> otpFocusNodes = List.generate(4, (index) => FocusNode());

  // Observable states
  final isLoading = false.obs;
  final isResending = false.obs;
  final canResend = false.obs;
  final resendTimer = 60.obs;

  // User phone number from storage
  String? userPhone;

  @override
  void onInit() {
    super.onInit();
    _loadUserPhone();
    _startResendTimer();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void _loadUserPhone() {
    userPhone = _storageService.read('phone');
    debugPrint('📱 User phone: $userPhone');
  }

  void _startResendTimer() {
    resendTimer.value = 60;
    canResend.value = false;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTimer.value > 0) {
        resendTimer.value--;
        return true;
      } else {
        canResend.value = true;
        return false;
      }
    });
  }

  /// Get the complete OTP code
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  /// Check if OTP is complete (all 4 digits filled)
  bool isOtpComplete() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  /// Handle OTP field changes
  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      // Move to next field
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field on delete
      otpFocusNodes[index - 1].requestFocus();
    }

    // Auto-submit when all fields are filled
    if (isOtpComplete()) {
      verifyCode();
    }
  }

  /// Verify the OTP code
  Future<void> verifyCode() async {
    if (!isOtpComplete()) {
      _showError(tr(LocaleKeys.invalid_code));
      return;
    }

    if (userPhone == null) {
      _showError('Phone number not found. Please login again.');
      Get.offAllNamed(Routes.login);
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Verifying code...');

      final code = int.tryParse(getOtpCode());
      if (code == null) {
        _showError(tr(LocaleKeys.invalid_code));
        return;
      }

      final response = await _apiService.verifyCode(
        phone: userPhone!,
        code: code,
        forVerifyAccount: true, // 1 for account verification, 0 for forgot password
      );

      debugPrint('📡 Verify response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = data['user'];

        // Update stored user data
        _storageService.write('user_id', user['id']);
        _storageService.write('first_name', user['first_name']);
        _storageService.write('last_name', user['last_name']);
        _storageService.write('phone', user['phone']);
        _storageService.write('city_id', user['city_id']);
        _storageService.write('is_verified', true);

        debugPrint('✅ Verification successful');

        Get.snackbar(
          tr(LocaleKeys.success),
          'Account verified successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        );

        // Navigate to home
        await Future.delayed(const Duration(seconds: 1));

        // TODO: Uncomment when home page is ready
        // Get.offAllNamed(Routes.home);

        // For now, show a message
        Get.snackbar(
          tr(LocaleKeys.success),
          'Navigate to home page',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: const EdgeInsets.all(16),
        );
      } else {
        final message = response.data['message'] ?? tr(LocaleKeys.invalid_code);
        _showError(message);
        _clearOtpFields();
      }
    } on DioException catch (e) {
      debugPrint('❌ Verify error: ${e.message}');

      if (e.response != null) {
        final message = e.response?.data['message'] ?? tr(LocaleKeys.invalid_code);
        _showError(message);
      } else {
        _showError(tr(LocaleKeys.network_error));
      }
      _clearOtpFields();
    } catch (e) {
      debugPrint('❌ Unexpected verify error: $e');
      _showError(tr(LocaleKeys.network_error));
      _clearOtpFields();
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend verification code
  Future<void> resendCode() async {
    if (!canResend.value) {
      return;
    }

    if (userPhone == null) {
      _showError('Phone number not found. Please login again.');
      Get.offAllNamed(Routes.login);
      return;
    }

    try {
      isResending.value = true;
      debugPrint('🔄 Resending code...');

      final response = await _apiService.resendCode(phone: userPhone!);

      debugPrint('📡 Resend response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('✅ Code resent successfully');

        Get.snackbar(
          tr(LocaleKeys.success),
          tr(LocaleKeys.code_resent),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: const EdgeInsets.all(16),
        );

        _clearOtpFields();
        _startResendTimer();
      } else {
        final message = response.data['message'] ?? 'Failed to resend code';
        _showError(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Resend error: ${e.message}');

      if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Failed to resend code';
        _showError(message);
      } else {
        _showError(tr(LocaleKeys.network_error));
      }
    } catch (e) {
      debugPrint('❌ Unexpected resend error: $e');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isResending.value = false;
    }
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpFocusNodes[0].requestFocus();
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
}
