import 'package:get/get.dart';

// Auth
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/pages/login_page.dart';
// Splash
import '../../features/splash_screen/presentation/bindings/splash_binding.dart';
import '../../features/splash_screen/presentation/pages/splash_page.dart';

// Home
// import '../../features/home/presentation/bindings/home_binding.dart';
// import '../../features/home/presentation/pages/home_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(name: Routes.login, page: () => LoginPage(), binding: LoginBinding()),
    // Add more routes as you build them
  ];
}
