import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Line height in Figma (140% = 1.4 in Flutter)
class AppTextStyles {
  // Font family constant
  static const String fontFamily = 'Lato';

  // ==================== HEADINGS ====================

  /// H1 - Main page titles
  /// Lato Regular, 32px, 140% line height
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w400, // Regular
    height: 1.4, // 140% line height
    color: AppColors.textPrimary,
  );

  /// H1 Bold variant
  /// Lato Bold, 32px, 140% line height
  static const TextStyle h1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H1 Medium variant
  /// Lato Medium, 32px, 140% line height
  static const TextStyle h1Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w500, // Medium
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H2 - Section headers
  /// Lato Regular, 48px, 140% line height
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H2 Bold variant
  /// Lato Bold, 48px, 140% line height
  static const TextStyle h2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H2 Medium variant
  /// Lato Medium, 48px, 140% line height
  static const TextStyle h2Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H3 - Subsection headers
  /// Lato Regular, 28px, 140% line height
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H3 Bold variant
  /// Lato Bold, 28px, 140% line height
  static const TextStyle h3Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H3 Medium variant
  /// Lato Medium, 28px, 140% line height
  static const TextStyle h3Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H4 - Small headers
  /// Lato Regular, 27px, 140% line height
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 27,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H4 Bold variant
  /// Lato Bold, 27px, 140% line height
  static const TextStyle h4Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 27,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H4 Medium variant
  /// Lato Medium, 27px, 140% line height
  static const TextStyle h4Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 27,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H5 - Smallest headers
  /// Lato Regular, 78px, 140% line height
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H5 Bold variant
  /// Lato Bold, 78px, 140% line height
  static const TextStyle h5Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H5 Medium variant
  /// Lato Medium, 78px, 140% line height
  static const TextStyle h5Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // ==================== TITLES ====================

  /// Title 1 - Large titles
  /// Lato Regular, 78px, 140% line height
  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Title 1 Bold variant
  /// Lato Bold, 78px, 140% line height
  static const TextStyle title1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Title 1 Medium variant
  /// Lato Medium, 78px, 140% line height
  static const TextStyle title1Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Title 2 - Medium titles
  /// Lato Regular, 78px, 140% line height
  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Title 2 Bold variant
  /// Lato Bold, 78px, 140% line height
  static const TextStyle title2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Title 2 Medium variant
  /// Lato Medium, 78px, 140% line height
  static const TextStyle title2Mid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 78,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // ==================== BODY TEXT ====================

  /// Body - Regular body text
  /// Lato Regular, 14px
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// Body Bold - Emphasized body text
  /// Lato Bold, 14px
  static const TextStyle bodyBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  /// Body Medium - Medium weight body text
  /// Lato Medium, 14px
  static const TextStyle bodyMid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // ==================== CAPTION ====================

  /// Caption - Small auxiliary text
  /// Lato Regular, 12px
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// Caption Bold variant
  /// Lato Bold, 12px
  static const TextStyle captionBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  /// Caption Medium variant
  /// Lato Medium, 12px
  static const TextStyle captionMid = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
