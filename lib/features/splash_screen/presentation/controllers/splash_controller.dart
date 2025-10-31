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

      // Check if user is logged in
      final isLoggedIn = _storage.read('is_logged_in') ?? false;
      debugPrint('🔑 isLoggedIn: $isLoggedIn');

      // For now, always navigate to login
      // You can add your home route navigation logic later
      debugPrint('🔑 Navigating to login');
      Get.offAllNamed(Routes.login);
    } catch (e, stackTrace) {
      debugPrint('❌ Error in _navigateToNextScreen: $e');
      debugPrint('Stack trace: $stackTrace');
      // Fallback to login screen in case of error
      Get.offAllNamed(Routes.login);
    }
  }
}
