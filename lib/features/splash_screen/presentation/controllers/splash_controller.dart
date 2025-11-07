import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/routes/app_pages.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();

  @override
  void onInit() {
    debugPrint('✅ SplashController onInit called');
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      debugPrint('🔄 Starting navigation check...');

      // Wait 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      debugPrint('⏰ 3 seconds elapsed');

      // Check if user has a token (proper authentication check)
      final token = _storage.read('token');
      final isLoggedIn = token != null && token.toString().isNotEmpty;

      debugPrint('🔑 Has token: $isLoggedIn');
      debugPrint('🔑 Token value: ${token != null ? "exists" : "null"}');

      if (isLoggedIn) {
        // User is authenticated, navigate to home
        debugPrint('✅ Navigating to home');
        // TODO: Uncomment when home page is ready
        // Get.offAllNamed(Routes.home);

        // Temporary: Navigate to login until home is implemented
        debugPrint('⚠️ Home not implemented yet, navigating to login');
        Get.offAllNamed(Routes.login);
      } else {
        // User is not authenticated, navigate to register page
        debugPrint('🔑 No token found, navigating to register');
        Get.offAllNamed(Routes.register);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error in _navigateToNextScreen: $e');
      debugPrint('Stack trace: $stackTrace');
      // Fallback to register screen in case of error
      Get.offAllNamed(Routes.register);
    }
  }
}
