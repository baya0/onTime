part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = '/splash';
  static const home = '/home';

  // Auth routes
  static const login = '/auth/login';
  static const register = '/auth/register';

  // Other routes
  static const categories = '/categories';
  static const serviceProviders = '/service-providers';
  static const offers = '/offers';
  static const profile = '/profile';
  static const settings = '/settings';
}
