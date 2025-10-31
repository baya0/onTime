abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Server error occurred'});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message = 'No internet connection'});
}

class AuthFailure extends Failure {
  AuthFailure({super.message = 'Authentication failed'});
}

class ValidationFailure extends Failure {
  ValidationFailure({super.message = 'Validation failed'});
}

class CacheFailure extends Failure {
  CacheFailure({super.message = 'Cache error'});
}
