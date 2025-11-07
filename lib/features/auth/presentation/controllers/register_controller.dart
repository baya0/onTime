import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/storage_service.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = Get.find();
  final AuthService _authService = Get.find();
  final StorageService _storageService = Get.find();

  // Text controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool agreeToTerms = false.obs;

  // City selection
  final RxList<Map<String, dynamic>> cities = <Map<String, dynamic>>[].obs;
  final RxBool isLoadingCities = false.obs;
  final Rxn<int> selectedCityId = Rxn<int>();
  final Rxn<String> selectedCityName = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    loadCities();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void selectCity(int cityId, String cityName) {
    selectedCityId.value = cityId;
    selectedCityName.value = cityName;
    print('✅ Selected city: $cityName (ID: $cityId)');
  }

  Future<void> loadCities() async {
    try {
      isLoadingCities.value = true;
      print('🔄 Loading cities...');

      final response = await _apiService.getCities();

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List;
        cities.value = data.map((city) => {'id': city['id'], 'name': city['name']}).toList();

        print('✅ Loaded ${cities.length} cities');
      } else {
        print('❌ Failed to load cities: ${response.data}');
        Get.snackbar(
          'error'.tr,
          'failed_to_load_cities'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print('❌ Error loading cities: $e');
      Get.snackbar(
        'error'.tr,
        'network_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoadingCities.value = false;
    }
  }

  Future<void> register() async {
    // Validation
    if (!_validateInputs()) {
      return;
    }

    try {
      isLoading.value = true;
      print('🔄 Starting registration...');

      final response = await _apiService.register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        cityId: selectedCityId.value!,
      );

      print('📡 Register response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final bool isVerified = data['verify'] ?? false;
        final user = data['user'];

        // Store user data
        _storageService.write('user_id', user['id']);
        _storageService.write('first_name', user['first_name']);
        _storageService.write('last_name', user['last_name']);
        _storageService.write('phone', user['phone']);
        _storageService.write('city_id', user['city_id']);
        _storageService.write('is_verified', isVerified);

        print('✅ Registration successful');
        print('   User ID: ${user['id']}');
        print('   Phone: ${user['phone']}');
        print('   Verified: $isVerified');

        Get.snackbar(
          'success'.tr,
          'register_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );

        // Navigate to verification screen if not verified
        // For now, navigate to login
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.login);

        // TODO: Navigate to OTP verification if isVerified is false
        // if (!isVerified) {
        //   Get.offAllNamed(Routes.otpVerification, arguments: {
        //     'phone': phoneController.text.trim(),
        //   });
        // } else {
        //   Get.offAllNamed(Routes.home);
        // }
      } else {
        final message = response.data['message'] ?? 'registration_failed'.tr;
        print('❌ Registration failed: $message');

        Get.snackbar(
          'error'.tr,
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print('❌ Registration error: $e');
      Get.snackbar(
        'error'.tr,
        'network_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    // Check first name
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'first_name_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check last name
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'last_name_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check phone
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'phone_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check phone format (should be 9 digits after +963)
    if (phoneController.text.trim().length < 9) {
      Get.snackbar(
        'error'.tr,
        'invalid_phone'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check city selection
    if (selectedCityId.value == null) {
      Get.snackbar(
        'error'.tr,
        'city_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check password
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'password_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check password length
    if (passwordController.text.length < 8) {
      Get.snackbar(
        'error'.tr,
        'password_too_short'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'error'.tr,
        'passwords_dont_match'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check terms agreement
    if (!agreeToTerms.value) {
      Get.snackbar(
        'error'.tr,
        'must_agree_to_terms'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    return true;
  }

  void navigateToLogin() {
    Get.offAllNamed(Routes.login);
  }
}
