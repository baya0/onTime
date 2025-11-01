import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Designed for iPhone Xs Max/14-15 Pro Max (430x932) as base
class ResponsiveHelper {
  // Base design dimensions
  static const double baseWidth = 430.0;
  static const double baseHeight = 932.0;

  /// Get screen width
  static double get screenWidth => Get.width;

  /// Get screen height
  static double get screenHeight => Get.height;

  /// Get safe area top padding
  static double get safeAreaTop => Get.mediaQuery.padding.top;

  /// Get safe area bottom padding
  static double get safeAreaBottom => Get.mediaQuery.padding.bottom;

  /// Get keyboard height
  static double get keyboardHeight => Get.mediaQuery.viewInsets.bottom;

  /// Check if keyboard is visible
  static bool get isKeyboardVisible => keyboardHeight > 0;

  /// Scale width based on screen size
  static double scaleWidth(double size) {
    return (size / baseWidth) * screenWidth;
  }

  /// Scale height based on screen size
  static double scaleHeight(double size) {
    return (size / baseHeight) * screenHeight;
  }

  /// Scale font size based on screen width
  static double scaleFontSize(double size) {
    return (size / baseWidth) * screenWidth;
  }

  /// Responsive value based on screen width breakpoints
  static T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (screenWidth >= 1024 && desktop != null) {
      return desktop;
    } else if (screenWidth >= 768 && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Check if device is mobile (< 768)
  static bool get isMobile => screenWidth < 768;

  /// Check if device is tablet (768-1024)
  static bool get isTablet => screenWidth >= 768 && screenWidth < 1024;

  /// Check if device is desktop (>= 1024)
  static bool get isDesktop => screenWidth >= 1024;

  /// Check if screen is small (< 375)
  static bool get isSmallScreen => screenWidth < 375;

  /// Check if screen is large (>= 430)
  static bool get isLargeScreen => screenWidth >= 430;

  /// Get orientation
  static Orientation get orientation => Get.mediaQuery.orientation;

  /// Check if portrait
  static bool get isPortrait => orientation == Orientation.portrait;

  /// Check if landscape
  static bool get isLandscape => orientation == Orientation.landscape;
}

/// Extension for easier responsive sizing on numbers
extension ResponsiveNum on num {
  /// Scale width
  double get w => ResponsiveHelper.scaleWidth(toDouble());

  /// Scale height
  double get h => ResponsiveHelper.scaleHeight(toDouble());

  /// Scale font size
  double get sp => ResponsiveHelper.scaleFontSize(toDouble());
}

/// Responsive Widget Builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}
