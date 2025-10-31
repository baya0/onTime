import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/constants/api_constants.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Dio instance
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // DataSource
    final dataSource = AuthRemoteDataSourceImpl(dio: dio);

    // Repository
    final repository = AuthRepositoryImpl(remoteDataSource: dataSource);

    // UseCase
    final loginUseCase = LoginUseCase(repository: repository);

    // Controller
    Get.lazyPut<LoginController>(() => LoginController(loginUseCase: loginUseCase));
  }
}
