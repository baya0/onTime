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

      await Future.delayed(const Duration(seconds: 3));

      final token = _storage.read('token');
      final isLoggedIn = token != null && token.toString().isNotEmpty;

      debugPrint('🔑 Has token: $isLoggedIn');

      if (isLoggedIn) {
        // Has token → Go to home
        debugPrint('✅ Navigating to home');
        Get.offAllNamed(Routes.home); // When ready
        // Get.offAllNamed(Routes.login); // Temporary
      } else {
        // No token → Go to LOGIN (not register!)
        debugPrint('🔑 No token found, navigating to LOGIN');
        Get.offAllNamed(Routes.login); // ← CHANGE THIS
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error: $e');
      Get.offAllNamed(Routes.login); // ← CHANGE THIS TOO
    }
  }
}
