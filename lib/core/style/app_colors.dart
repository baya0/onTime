import 'package:flutter/material.dart';

class AppColors {
  // ==================== DEFAULT COLORS ====================

  /// Main brand color (Orange)
  static const Color primary = Color(0xFFFF6F00);

  /// Secondary brand color (Green)
  static const Color secondary = Color(0xFF384728);

  /// Tertiary brand color (Purple/Blue)
  static const Color tertiary = Color(0xFFD2DFF9);

  // ==================== ORANGE SCALE ====================

  static const Color orange50 = Color(0xFFFFF3E0);
  static const Color orange100 = Color(0xFFFFE0B2);
  static const Color orange200 = Color(0xFFFFCC80);
  static const Color orange300 = Color(0xFFFFB74D);
  static const Color orange400 = Color(0xFFFFA726);
  static const Color orange500 = Color(0xFFFF9800); // Base orange
  static const Color orange600 = Color(0xFFFB8C00);
  static const Color orange700 = Color(0xFFF57C00);
  static const Color orange800 = Color(0xFFEF6C00);
  static const Color orange900 = Color(0xFFE65100);

  // ==================== GREEN SCALE ====================

  static const Color green50 = Color(0xFFE8F5E9);
  static const Color green100 = Color(0xFFC8E6C9);
  static const Color green200 = Color(0xFFA5D6A7);
  static const Color green300 = Color(0xFF81C784);
  static const Color green400 = Color(0xFF66BB6A);
  static const Color green500 = Color(0xFF4CAF50); // Base green
  static const Color green600 = Color(0xFF43A047);
  static const Color green700 = Color(0xFF388E3C);
  static const Color green800 = Color(0xFF2E7D32);
  static const Color green900 = Color(0xFF1B5E20);

  // ==================== PURPLE (TERTIARY) SCALE ====================

  static const Color purple50 = Color(0xFFF3E5F5);
  static const Color purple100 = Color(0xFFE1BEE7);
  static const Color purple200 = Color(0xFFCE93D8);
  static const Color purple300 = Color(0xFFBA68C8);
  static const Color purple400 = Color(0xFFAB47BC);
  static const Color purple500 = Color(0xFF9C27B0); // Base purple
  static const Color purple600 = Color(0xFF8E24AA);
  static const Color purple700 = Color(0xFF7B1FA2);
  static const Color purple800 = Color(0xFF6A1B9A);
  static const Color purple900 = Color(0xFF4A148C);

  // ==================== GRAY SCALE ====================

  /// Gray Scale Most Dark
  static const Color grayMostDark = Color(0xFF919191);

  /// Gray Scale Less Dark
  static const Color grayLessDark = Color(0xFFB0B0B0);

  /// Gray Scale Least Dark
  static const Color grayLeastDark = Color(0xFFEAEAEA);

  // ==================== STATUS COLORS ====================

  /// Danger/Error Status - Primary
  static const Color dangerPrimary = Color(0xFFD85A5A);

  /// Danger/Error Status - Light
  static const Color dangerLight = Color(0xFFFCE1E2);

  // ==================== COMMON UI COLORS ====================

  /// Pure white for backgrounds
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black for text
  static const Color black = Color(0xFF000000);

  /// Success color (you can use green500 or define custom)
  static const Color success = green500;

  /// Warning color (you can use orange500 or define custom)
  static const Color warning = orange500;

  /// Error color
  static const Color error = dangerPrimary;

  // ==================== TEXT COLORS ====================

  /// Primary text color
  static const Color textPrimary = Color(0xFF212121);

  /// Secondary text color
  static const Color textSecondary = grayMostDark;

  /// Disabled text color
  static const Color textDisabled = grayLessDark;

  /// Light text (for dark backgrounds)
  static const Color textLight = white;

  // ==================== BACKGROUND COLORS ====================

  /// Main background
  static const Color background = white;

  /// Surface background
  static const Color surface = grayLeastDark;

  /// Card background
  static const Color cardBackground = white;
}
