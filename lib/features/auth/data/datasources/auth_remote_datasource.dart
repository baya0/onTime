import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({required String phone, required String password});

  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> login({required String phone, required String password}) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  }) async {
    try {
      final response = await dio.post(
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

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Registration failed');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.delete(ApiConstants.logout);
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }
}
