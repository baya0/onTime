import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/app_colors.dart';

class LoginController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Focus nodes
  final phoneFocusNode = FocusNode();
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
    phoneController.dispose();
    passwordController.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void _loadSavedCredentials() {
    // TODO: Implement loading from storage service
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// Validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr; // CHANGED: Use .tr() instead of .tr
    }
    // Syrian phone number format: 09XXXXXXXX
    if (!RegExp(r'^09[0-9]{8}$').hasMatch(value)) {
      return 'invalid_phone'.tr; // CHANGED
    }
    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    if (value.length < 8) {
      return 'password_too_short'.tr;
    }
    return null;
  }

  /// Login function
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement actual login API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      Get.snackbar(
        'success'.tr, // CHANGED
        'login_success'.tr, // CHANGED
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to home
      // Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'error'.tr, // CHANGED
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToForgotPassword() {
    // Get.toNamed(AppRoutes.forgotPassword);
  }

  void goToRegister() {
    // Get.toNamed(AppRoutes.register);
  }

  void continueAsGuest() {
    // Get.offAllNamed(AppRoutes.home);
  }

  void becomeProvider() {
    // Get.toNamed(AppRoutes.becomeProvider);
  }
}
