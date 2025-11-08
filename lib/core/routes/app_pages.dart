import 'package:get/get.dart';

// Auth
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/bindings/register_binding.dart';
import '../../features/auth/presentation/bindings/verify_binding.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/verify_page.dart';
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
    GetPage(name: Routes.splash, page: () => const SplashPage(), binding: SplashBinding()),
    GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.register, page: () => const RegisterPage(), binding: RegisterBinding()),
    GetPage(name: Routes.verify, page: () => const VerifyPage(), binding: VerifyBinding()),
    // Add more routes as you build them
  ];
}
