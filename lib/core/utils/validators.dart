import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../localization/strings.dart';

/// Centralized validation utilities for the entire app
/// Provides reusable validators with proper error messages
class Validators {
  Validators._(); // Private constructor to prevent instantiation

  // ============================================================
  // PHONE NUMBER VALIDATION
  // ============================================================

  /// Validates Syrian phone numbers with flexible formatting
  /// Accepts: 09XXXXXXXX, 9XXXXXXXX, +96309XXXXXXXX, 96309XXXXXXXX
  /// Returns the error message or null if valid
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.phone_required);
    }

    try {
      final cleanedPhone = _cleanPhoneNumber(value);

      // Try to parse as Syrian number
      final phoneNumber = PhoneNumber.parse(
        cleanedPhone,
        callerCountry: IsoCode.SY, // Syria
      );

      // Validate it's a valid Syrian mobile number
      if (!phoneNumber.isValid() || phoneNumber.countryCode != '963') {
        return tr(LocaleKeys.invalid_phone);
      }

      // Syrian mobile numbers should be 9 digits after country code (9XXXXXXXX)
      final nationalNumber = phoneNumber.nsn; // National Significant Number
      if (nationalNumber.length != 9 || !nationalNumber.startsWith('9')) {
        return tr(LocaleKeys.invalid_phone);
      }

      return null;
    } catch (e) {
      return tr(LocaleKeys.invalid_phone);
    }
  }

  /// Cleans and prepares phone number for validation
  /// Handles various input formats
  static String _cleanPhoneNumber(String phone) {
    // Remove all spaces, dashes, parentheses
    String cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // If starts with +963, keep it
    if (cleaned.startsWith('+963')) {
      return cleaned;
    }

    // If starts with 963, add +
    if (cleaned.startsWith('963')) {
      return '+$cleaned';
    }

    // If starts with 09, convert to +9639
    if (cleaned.startsWith('09')) {
      return '+963${cleaned.substring(1)}';
    }

    // If starts with 9 (just the number), add +963
    if (cleaned.startsWith('9') && cleaned.length == 9) {
      return '+963$cleaned';
    }

    // Return as is and let parser handle it
    return cleaned;
  }

  /// Formats phone number for API submission
  /// Converts any format to 09XXXXXXXX format expected by backend
  static String formatPhoneForAPI(String phone) {
    try {
      final cleanedPhone = _cleanPhoneNumber(phone);
      final phoneNumber = PhoneNumber.parse(cleanedPhone, callerCountry: IsoCode.SY);

      if (phoneNumber.isValid() && phoneNumber.countryCode == '963') {
        // Return in format: 09XXXXXXXX
        return '0${phoneNumber.nsn}';
      }
    } catch (e) {
      // If parsing fails, try simple cleanup
    }

    // Fallback: simple cleanup
    String cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    if (cleaned.startsWith('963')) {
      return '0${cleaned.substring(3)}';
    }

    if (!cleaned.startsWith('0') && cleaned.startsWith('9')) {
      return '0$cleaned';
    }

    return cleaned;
  }

  /// Formats phone number for display (with country code)
  /// Returns in format: +963 9XX XXX XXX
  static String formatPhoneForDisplay(String phone) {
    try {
      final cleanedPhone = _cleanPhoneNumber(phone);
      final phoneNumber = PhoneNumber.parse(cleanedPhone, callerCountry: IsoCode.SY);

      if (phoneNumber.isValid()) {
        return phoneNumber.international; // Returns formatted international number
      }
    } catch (e) {
      // Fallback to simple formatting
    }

    // Simple fallback formatting
    String cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.startsWith('09') && cleaned.length == 10) {
      return '+963 ${cleaned.substring(1, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
    }

    return phone;
  }

  // ============================================================
  // PASSWORD VALIDATION
  // ============================================================

  /// Validates password with configurable requirements
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireDigit = false,
    bool requireSpecialChar = false,
  }) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.password_required);
    }

    if (value.length < minLength) {
      return tr(LocaleKeys.password_too_short);
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validates password confirmation matches
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.field_required);
    }

    if (value != password) {
      return tr(LocaleKeys.passwords_dont_match);
    }

    return null;
  }

  // ============================================================
  // NAME VALIDATION
  // ============================================================

  /// Validates first name
  static String? firstName(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.first_name_required);
    }

    final trimmed = value.trim();

    if (trimmed.length < minLength) {
      return 'First name must be at least $minLength characters';
    }

    if (trimmed.length > maxLength) {
      return 'First name must be less than $maxLength characters';
    }

    // Only letters and spaces allowed
    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(trimmed)) {
      return 'First name can only contain letters';
    }

    return null;
  }

  /// Validates last name
  static String? lastName(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.last_name_required);
    }

    final trimmed = value.trim();

    if (trimmed.length < minLength) {
      return 'Last name must be at least $minLength characters';
    }

    if (trimmed.length > maxLength) {
      return 'Last name must be less than $maxLength characters';
    }

    // Only letters and spaces allowed
    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(trimmed)) {
      return 'Last name can only contain letters';
    }

    return null;
  }

  // ============================================================
  // EMAIL VALIDATION
  // ============================================================

  /// Validates email address
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return tr(LocaleKeys.invalid_email);
    }

    return null;
  }

  // ============================================================
  // GENERAL VALIDATION
  // ============================================================

  /// Validates required field
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      if (fieldName != null) {
        return '$fieldName is required';
      }
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.field_required);
    }

    if (value.length < min) {
      final field = fieldName ?? 'This field';
      return '$field must be at least $min characters';
    }

    return null;
  }

  /// Validates maximum length
  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    if (value.length > max) {
      final field = fieldName ?? 'This field';
      return '$field must be less than $max characters';
    }

    return null;
  }

  /// Validates numeric input
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }

    if (int.tryParse(value.trim()) == null) {
      final field = fieldName ?? 'This field';
      return '$field must be a valid number';
    }

    return null;
  }

  /// Validates OTP code (4 or 6 digits)
  static String? otpCode(String? value, {int length = 4}) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }

    if (value.length != length) {
      return 'Code must be $length digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Code must contain only numbers';
    }

    return null;
  }

  // ============================================================
  // COMPOSITE VALIDATORS
  // ============================================================

  /// Combines multiple validators
  /// Returns first error found or null if all pass
  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}

// ============================================================
// PHONE NUMBER INPUT FORMATTER
// ============================================================

/// Text input formatter for Syrian phone numbers
/// Automatically formats as user types: 09XX XXX XXX
class SyrianPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove all non-digits
    String digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    // If empty or starts with 0, allow it
    if (digitsOnly.isEmpty) {
      return newValue;
    }

    // Ensure it starts with 09
    if (!digitsOnly.startsWith('0')) {
      digitsOnly = '0$digitsOnly';
    }

    if (digitsOnly.length > 1 && digitsOnly[1] != '9') {
      // Auto-correct to start with 09
      if (digitsOnly.startsWith('0')) {
        digitsOnly = '09${digitsOnly.substring(1)}';
      }
    }

    // Limit to 10 digits (09 + 8 digits)
    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(0, 10);
    }

    // Format as: 09XX XXX XXX
    String formatted = digitsOnly;
    if (digitsOnly.length > 4) {
      formatted = '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4)}';
    }
    if (digitsOnly.length > 7) {
      formatted =
          '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4, 7)} ${digitsOnly.substring(7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
