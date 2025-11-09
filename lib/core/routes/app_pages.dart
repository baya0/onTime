import 'package:get/get.dart';

// Core
import '../../core/routes/app_transitions.dart';

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

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    // Splash - No transition needed (first screen)
    GetPage(name: Routes.splash, page: () => const SplashPage(), binding: SplashBinding()),

    // Login - Smooth fade transition from splash
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppTransitions.standardDuration,
    ),

    // Register - Shared axis (related to login)
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      customTransition: AppTransitions.sharedAxis,
      transitionDuration: AppTransitions.standardDuration,
    ),

    // Verify - Platform adaptive slide
    GetPage(
      name: Routes.verify,
      page: () => const VerifyPage(),
      binding: VerifyBinding(),
      customTransition: AppTransitions.platformAdaptive,
      transitionDuration: AppTransitions.standardDuration,
    ),

    // Future home page example:
    // GetPage(
    //   name: Routes.home,
    //   page: () => const HomePage(),
    //   binding: HomeBinding(),
    //   customTransition: AppTransitions.smoothFade,
    //   transitionDuration: AppTransitions.fastDuration,
    // ),
  ];
}
