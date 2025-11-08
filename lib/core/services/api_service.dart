import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class ApiService {
  late Dio _dio;
  String? _token;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );

    // Add auth token to requests
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  // Categories
  Future<Response> getCategories({String? name}) async {
    return await _dio.get(
      ApiConstants.categories,
      queryParameters: name != null ? {'name': name} : null,
    );
  }

  // Service Providers
  Future<Response> getServiceProviders({
    String? name,
    int? categoryId,
    int? subCategoryId,
    int? cityId,
    List<int>? tags,
  }) async {
    Map<String, dynamic> params = {};
    if (name != null) params['name'] = name;
    if (categoryId != null) params['category_id'] = categoryId;
    if (subCategoryId != null) params['sub_category_id'] = subCategoryId;
    if (cityId != null) params['city_id'] = cityId;
    if (tags != null) {
      for (int i = 0; i < tags.length; i++) {
        params['tags[$i]'] = tags[i];
      }
    }

    return await _dio.get(
      ApiConstants.serviceProviders,
      queryParameters: params.isNotEmpty ? params : null,
    );
  }

  // Sliders
  Future<Response> getSliders() async {
    return await _dio.get(ApiConstants.sliders);
  }

  // Auth - Register
  Future<Response> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  }) async {
    return await _dio.post(
      ApiConstants.register,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'city_id': cityId,
      },
    );
  }

  // Auth - Login
  Future<Response> login({required String phone, required String password}) async {
    return await _dio.post(ApiConstants.login, data: {'phone': phone, 'password': password});
  }

  // Auth - Verify Code
  Future<Response> verifyCode({
    required String phone,
    required int code,
    required bool forVerifyAccount,
  }) async {
    return await _dio.post(
      ApiConstants.verifyCode,
      data: {
        'phone': phone,
        'code': code,
        'for_verifiy_account': forVerifyAccount ? 1 : 0, // Note: API uses 'verifiy' typo
      },
    );
  }

  // Auth - Resend Code
  Future<Response> resendCode({required String phone}) async {
    return await _dio.post(ApiConstants.resendCode, data: {'phone': phone});
  }

  // Auth - Logout
  Future<Response> logout() async {
    return await _dio.delete(ApiConstants.logout);
  }

  // Get Profile
  Future<Response> getProfile() async {
    return await _dio.get(ApiConstants.profile);
  }

  // Offers
  Future<Response> getOffers({String? name}) async {
    return await _dio.get(
      ApiConstants.offers,
      queryParameters: name != null ? {'name': name} : null,
    );
  }

  // Cities
  Future<Response> getCities({String? name}) async {
    return await _dio.get(
      ApiConstants.cities,
      queryParameters: name != null ? {'name': name} : null,
    );
  }
}
