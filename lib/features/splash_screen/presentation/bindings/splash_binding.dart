import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print('🔧 SplashBinding.dependencies() called');
    Get.put<SplashController>(
      // ← FIX: Create immediately!
      SplashController(),
    );
    print('🔧 SplashBinding: Controller created');
  }
}
