import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  // ==================== MID SHADOWS ====================

  /// Mid Shadow - Purple variant
  /// x:1, y:1, blur:7, spread:0
  /// Color: #A55DBB
  static final List<BoxShadow> midShadowPurple = [
    BoxShadow(color: Color(0xFFA55DBB), offset: Offset(1, 1), blurRadius: 7, spreadRadius: 0),
  ];

  /// Mid Shadow - Gray variant
  /// x:1, y:1, blur:7, spread:0
  /// Color: #B0B0B0
  static final List<BoxShadow> midShadowGray = [
    BoxShadow(
      color: AppColors.grayLessDark, // #B0B0B0
      offset: Offset(1, 1),
      blurRadius: 7,
      spreadRadius: 0,
    ),
  ];

  /// Mid Shadow - Light variant
  /// x:1, y:1, blur:7, spread:0
  /// Color: #D9DDE5
  static final List<BoxShadow> midShadowLight = [
    BoxShadow(color: Color(0xFFD9DDE5), offset: Offset(1, 1), blurRadius: 7, spreadRadius: 0),
  ];

  // ==================== CARD SHADOWS ====================

  /// Light card shadow - for elevated surfaces
  static final List<BoxShadow> cardLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  /// Medium card shadow - for interactive elements
  static final List<BoxShadow> cardMedium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  /// Strong card shadow - for prominent elements
  static final List<BoxShadow> cardStrong = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: Offset(0, 6),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // ==================== BUTTON SHADOWS ====================

  /// Button shadow - default state
  static final List<BoxShadow> button = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  /// Button shadow - pressed state
  static final List<BoxShadow> buttonPressed = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // ==================== BOTTOM SHEET SHADOW ====================

  /// Bottom sheet shadow
  static final List<BoxShadow> bottomSheet = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: Offset(0, -2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // ==================== MODAL SHADOW ====================

  /// Modal/Dialog shadow
  static final List<BoxShadow> modal = [
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      offset: Offset(0, 4),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];
}
