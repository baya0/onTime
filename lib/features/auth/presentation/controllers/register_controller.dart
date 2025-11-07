import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/style/app_colors.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Focus nodes
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Observable states
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final agreeToTerms = false.obs;

  // City selection
  final cities = <Map<String, dynamic>>[].obs;
  final isLoadingCities = false.obs;
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
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneFocusNode.dispose();
    cityFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  void selectCity(int cityId, String cityName) {
    selectedCityId.value = cityId;
    selectedCityName.value = cityName;
    debugPrint('✅ Selected city: $cityName (ID: $cityId)');
  }

  Future<void> loadCities() async {
    try {
      isLoadingCities.value = true;
      debugPrint('🔄 Loading cities...');

      final response = await _apiService.getCities();

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List;
        cities.value = data.map((city) => {'id': city['id'], 'name': city['name']}).toList();

        debugPrint('✅ Loaded ${cities.length} cities');
      } else {
        debugPrint('❌ Failed to load cities: ${response.data}');
        _showError(tr(LocaleKeys.failed_to_load_cities));
      }
    } catch (e) {
      debugPrint('❌ Error loading cities: $e');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isLoadingCities.value = false;
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!agreeToTerms.value) {
      _showError(tr(LocaleKeys.must_agree_to_terms));
      return;
    }

    if (selectedCityId.value == null) {
      _showError(tr(LocaleKeys.city_required));
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 Starting registration...');

      final response = await _apiService.register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        cityId: selectedCityId.value!,
      );

      debugPrint('📡 Register response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = data['user'];

        // Store user data
        _storageService.write('user_id', user['id']);
        _storageService.write('first_name', user['first_name']);
        _storageService.write('last_name', user['last_name']);
        _storageService.write('phone', user['phone']);
        _storageService.write('city_id', user['city_id']);

        debugPrint('✅ Registration successful');

        Get.snackbar(
          tr(LocaleKeys.success),
          tr(LocaleKeys.register_success),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green500.withOpacity(0.1),
          colorText: AppColors.green900,
          margin: EdgeInsets.all(16),
        );

        // Navigate to login
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.login);
      } else {
        final message = response.data['message'] ?? tr(LocaleKeys.registration_failed);
        _showError(message);
      }
    } catch (e) {
      debugPrint('❌ Registration error: $e');
      _showError(tr(LocaleKeys.network_error));
    } finally {
      isLoading.value = false;
    }
  }

  // Validators
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.first_name_required);
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.last_name_required);
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.phone_required);
    }
    if (value.trim().length < 9) {
      return tr(LocaleKeys.invalid_phone);
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.password_required);
    }
    if (value.length < 8) {
      return tr(LocaleKeys.password_too_short);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.password_required);
    }
    if (value != passwordController.text) {
      return tr(LocaleKeys.passwords_dont_match);
    }
    return null;
  }

  void _showError(String message) {
    Get.snackbar(
      tr(LocaleKeys.error),
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withOpacity(0.1),
      colorText: AppColors.error,
      margin: EdgeInsets.all(16),
    );
  }
}
