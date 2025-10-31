import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  // Controllers for text fields
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  // UseCase
  final LoginUseCase loginUseCase;

  // Storage
  final _storage = GetStorage();

  LoginController({required this.loginUseCase});

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login function
  Future<void> login() async {
    // Validate inputs
    if (phoneController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Start loading
    isLoading.value = true;

    // Call use case
    final result = await loginUseCase(
      phone: phoneController.text,
      password: passwordController.text,
    );

    // Handle result
    result.fold(
      // Failure
      (failure) {
        isLoading.value = false;
        Get.snackbar(
          'Login Failed',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      // Success
      (data) async {
        isLoading.value = false;

        // Save token
        final token = data['data']['token'];
        await _storage.write('auth_token', token);
        await _storage.write('is_logged_in', true);

        // Save user data
        final userData = data['data']['user'];
        await _storage.write('user_data', userData);

        // Show success message
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to home
        Get.offAllNamed('/home');
      },
    );
  }

  // Navigate to register
  void goToRegister() {
    Get.toNamed('/auth/register');
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    Get.toNamed('/auth/forgot-password');
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
