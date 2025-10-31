class ApiConstants {
  static const String baseUrl = 'http://94.72.98.154:8085/api';

  // Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';
  static const String verifyCode = '/auth/verify-code';
  static const String resendCode = '/auth/resend-code';
  static const String forgetPassword = '/auth/forget-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String updateProfile = '/auth/update-profile';

  static const String categories = '/categories';
  static const String subCategories = '/sub-categories';
  static const String serviceProviders = '/service-providers';
  static const String offers = '/offers';
  static const String sliders = '/sliders';
  static const String govermentEntities = '/goverment-entities';
  static const String notifications = '/notifications';
  static const String pages = '/pages';
  static const String settings = '/settings';
  static const String contacts = '/contacts';
  static const String tags = '/tags';
  static const String cities = '/cities';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
