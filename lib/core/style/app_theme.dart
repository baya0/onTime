import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

/// Combines colors, typography, and spacing into a cohesive theme
class AppTheme {
  // ==================== LIGHT THEME ====================

  static ThemeData get lightTheme {
    return ThemeData(
      // Brightness
      brightness: Brightness.light,

      // Primary colors
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        error: AppColors.error,
        surface: AppColors.surface,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onError: AppColors.white,
        onSurface: AppColors.textPrimary,
      ),

      // Typography
      textTheme: TextTheme(
        // Display styles (largest)
        displayLarge: AppTextStyles.h2,
        displayMedium: AppTextStyles.h1,
        displaySmall: AppTextStyles.title1,

        // Headline styles
        headlineLarge: AppTextStyles.h2,
        headlineMedium: AppTextStyles.h3,
        headlineSmall: AppTextStyles.h4,

        // Title styles
        titleLarge: AppTextStyles.title1,
        titleMedium: AppTextStyles.title2,
        titleSmall: AppTextStyles.h5,

        // Body styles
        bodyLarge: AppTextStyles.bodyBold,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,

        // Label styles
        labelLarge: AppTextStyles.bodyBold,
        labelMedium: AppTextStyles.body,
        labelSmall: AppTextStyles.caption,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h3.copyWith(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        margin: EdgeInsets.all(AppSpacing.space8),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.bodyBold,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.space24,
            vertical: AppSpacing.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          ),
          elevation: 2,
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.bodyBold,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.space24,
            vertical: AppSpacing.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          ),
          side: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.bodyBold,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space8,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        labelStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption,
        unselectedLabelStyle: AppTextStyles.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: AppColors.grayLeastDark,
        thickness: 1,
        space: AppSpacing.space16,
      ),

      // Icon theme
      iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.body.copyWith(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
        ),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        titleTextStyle: AppTextStyles.h3,
        contentTextStyle: AppTextStyles.body,
      ),
    );
  }

  // ==================== DARK THEME (later i might add it ) ====================

  static ThemeData get darkTheme {
    //  but For now, returning light theme :D
    return lightTheme;
  }
}
