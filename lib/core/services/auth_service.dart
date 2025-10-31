// core/services/auth_service.dart
import 'package:get/get.dart';

import 'storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storage = Get.find();

  // Observables
  final RxnString token = RxnString();
  final RxBool isVerified = false.obs;
  final RxBool isAuthenticated = false.obs;

  Future<AuthService> init() async {
    await _loadFromStorage();
    print('✅ AuthService initialized');
    return this;
  }

  Future<void> _loadFromStorage() async {
    token.value = _storage.read('token');
    isVerified.value = _storage.read('isVerified') ?? false;
    isAuthenticated.value = token.value != null && token.value!.isNotEmpty;

    print('📱 Auth state loaded:');
    print('   Token: ${token.value != null ? "✅" : "❌"}');
    print('   Verified: ${isVerified.value}');
    print('   Authenticated: ${isAuthenticated.value}');
  }

  // Setters
  void setToken(String? newToken) {
    token.value = newToken;
    if (newToken != null) {
      _storage.write('token', newToken);
      isAuthenticated.value = true;
    } else {
      _storage.remove('token');
      isAuthenticated.value = false;
    }
    print('🔑 Token ${newToken != null ? "set" : "cleared"}');
  }

  void setVerified(bool verified) {
    isVerified.value = verified;
    _storage.write('isVerified', verified);
    print('✅ Verified: $verified');
  }

  Future<void> logout() async {
    setToken(null);
    setVerified(false);
    print('👋 Logged out');
  }
}
