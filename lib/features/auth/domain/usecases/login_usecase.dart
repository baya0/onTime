import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, Map<String, dynamic>>> call({
    required String phone,
    required String password,
  }) async {
    if (phone.isEmpty) {
      return Left(ServerFailure(message: 'Phone number is required'));
    }
    if (password.isEmpty) {
      return Left(ServerFailure(message: 'Password is required'));
    }

    return await repository.login(phone: phone, password: password);
  }
}
