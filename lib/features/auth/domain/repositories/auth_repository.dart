import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String phone,
    required String password,
  });

  Future<Either<Failure, Map<String, dynamic>>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  });

  Future<Either<Failure, void>> logout();
}
