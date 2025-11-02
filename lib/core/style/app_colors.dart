import 'package:flutter/material.dart';

class AppColors {
  // ==================== DEFAULT COLORS ====================

  /// Main brand color (Orange) - orange-500
  static const Color primary = Color(0xFFFF6F00);

  /// Secondary brand color (Green) - green-500
  static const Color secondary = Color(0xFF384728);

  /// Tertiary brand color (Purple) - purple-500
  static const Color tertiary = Color(0xFFD2DFF9);

  // ==================== ORANGE SCALE ====================

  static const Color orange50 = Color(0xFFFFF1E6);
  static const Color orange100 = Color(0xfffffd2b0);
  static const Color orange200 = Color(0xFFFFBD8A);
  static const Color orange300 = Color(0xFFFFAF54);
  static const Color orange400 = Color(0xFFFF8C33);
  static const Color orange500 = Color(0xFFFF6F00); // Base orange (Primary)
  static const Color orange600 = Color(0xFFE66300);
  static const Color orange700 = Color(0xFFB54F00);
  static const Color orange800 = Color(0xFF8C3D00);
  static const Color orange900 = Color(0xFF6B2F00);

  // ==================== GREEN SCALE ====================

  static const Color green50 = Color(0xFFECEDEA);
  static const Color green100 = Color(0xFFC3C8BE);
  static const Color green200 = Color(0xFFA6AE9E);
  static const Color green300 = Color(0xFF7E8872);
  static const Color green400 = Color(0xFF657156);
  static const Color green500 = Color(0xFF3E4E2C); // Base green (Secondary)
  static const Color green600 = Color(0xFF384728);
  static const Color green700 = Color(0xFF2C371F);
  static const Color green800 = Color(0xFF222B18);
  static const Color green900 = Color(0xFF1A2112);

  // ==================== PURPLE (TERTIARY) SCALE ====================

  static const Color purple50 = Color(0xFFFBFCFE);
  static const Color purple100 = Color(0xFFF1F5FD);
  static const Color purple200 = Color(0xFFEAF0FC);
  static const Color purple300 = Color(0xFFE1CAFA);
  static const Color purple400 = Color(0xFFDBE5FA);
  static const Color purple500 = Color(0xFFD2DFF9); // Base purple (Tertiary)
  static const Color purple600 = Color(0xFFBFCBE3);
  static const Color purple700 = Color(0xFF959EB1);
  static const Color purple800 = Color(0xFF747B89);
  static const Color purple900 = Color(0xFF585E69);

  // ==================== GRAY SCALE ====================

  /// Gray Scale Most Dark -
  static const Color grayMostDark = Color(0xFF919191);

  /// Gray Scale Less Dark
  static const Color grayLessDark = Color(0xFFB0B0B0);

  /// Gray Scale Least Dark - #D9DDE5
  static const Color grayLeastDark = Color(0xFFEAEAEA);

  // ==================== STATUS COLORS ====================

  /// Danger/Error Status - Primary - #D85A5A
  static const Color dangerPrimary = Color(0xFFD85A5A);

  /// Danger/Error Status - Light - #FCE1E2
  static const Color dangerLight = Color(0xFFFCE1E2);

  // ==================== SHADOW COLORS ====================

  /// Mid Shadow - Purple variant - #A55DBB
  static const Color shadowPurple = Color(0xFFA55DBB);

  /// Mid Shadow - Gray variant - #B0B0B0
  static const Color shadowGray = Color(0xFFB0B0B0);

  /// Mid Shadow - Light variant - #D9DDE5
  static const Color shadowLight = Color(0xFFD9DDE5);

  // ==================== COMMON UI COLORS ====================

  /// Pure white for backgrounds
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black for text
  static const Color black = Color(0xFF000000);

  /// Success color (use green500)
  static const Color success = green500;

  /// Warning color (use orange500)
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
