import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends GetxService {
  final locale = Rx<Locale>(Locale('en'));
  final _storage = GetStorage();
  final String _key = 'language';

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  Future<LocalizationService> init() async {
    final savedLanguage = _storage.read(_key) ?? 'en';
    locale.value = Locale(savedLanguage);
    return this;
  }

  Future<void> changeLanguage(String languageCode) async {
    if (locale.value.languageCode == languageCode) return;

    locale.value = Locale(languageCode);
    await _storage.write(_key, languageCode);
    Get.updateLocale(locale.value);
  }

  bool get isArabic => locale.value.languageCode == 'ar';
  bool get isEnglish => locale.value.languageCode == 'en';
  String get currentLanguage => locale.value.languageCode;
}
