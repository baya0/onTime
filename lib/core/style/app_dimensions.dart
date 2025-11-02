import 'package:flutter/widgets.dart';

/// Designed for iPhone Xs Max/14-15 Pro Max (430x932)
class AppSpacing {
  // ==================== BASE SPACING INCREMENTS ====================
  // Based on 4px grid system

  /// 2px - Minimal spacing
  static const double space2 = 2.0;

  /// 4px - Base grid unit
  static const double space4 = 4.0;

  /// 8px - Small spacing / Gutter between grid columns
  static const double space8 = 8.0;

  /// 12px - Small-medium spacing
  static const double space12 = 12.0;

  /// 16px - Medium spacing / Distance between title and details
  /// (المسافة بين العنوان والتفاصيل)
  static const double space16 = 16.0;

  /// 20px - Medium-large spacing
  static const double space20 = 20.0;

  /// 24px - Large spacing / Distance between sections within page
  /// (المسافة بين الأقسام داخل الصفحة)
  static const double space24 = 24.0;

  /// 28px - Large spacing
  static const double space28 = 28.0;

  /// 32px - Extra large spacing
  static const double space32 = 32.0;

  /// 36px - Extra extra large spacing
  static const double space40 = 40.0;

  // ==================== SEMANTIC SPACING ====================
  // Named based on usage for better readability

  /// Minimal spacing between small elements
  static const double xs = space2;

  /// Small spacing between related elements
  static const double sm = space8;

  /// Medium spacing between elements
  static const double md = space16;

  /// Large spacing between sections
  static const double lg = space24;

  /// Extra large spacing
  static const double xl = space32;

  /// Extra extra large spacing
  static const double xxl = space40;

  // ==================== GRID LAYOUT ====================

  /// Number of columns in grid
  static const int gridColumns = 4;

  /// Gutter space between columns (مسافة بين الأعمدة)
  static const double gutter = space8;

  /// Margin on left/right sides of screen
  static const double margin = space16;

  /// Column width (calculated for 430px screen)
  static const double columnWidth = 94.0;

  // ==================== SCREEN PADDING ====================

  /// Top/Bottom padding for screens
  static const double screenPaddingVertical = space24;

  /// Left/Right padding for screens
  static const double screenPaddingHorizontal = margin;

  // ==================== CARD SPACING ====================

  /// Padding inside cards
  static const double cardPadding = space16;

  /// Spacing between cards
  static const double cardGap = space12;

  // ==================== BORDER RADIUS ====================

  /// Small border radius
  static const double borderRadiusXSmall = space8;

  /// Medium border radius
  static const double borderRadiusSmall = space12;

  /// Large border radius
  static const double borderRadiusMedium = space16;

  /// Extra large border radius
  static const double borderRadiusLarge = space24;

  /// Extra large border radius
  static const double borderRadiusXLarge = space32;

  /// Extra large border radius
  static const double borderRadiusXXLarge = space40;

  // ==================== COMMON EDGE INSETS ====================

  /// Screen padding (24px vertical, 16px horizontal)
  static const screenPadding = EdgeInsets.symmetric(
    vertical: screenPaddingVertical,
    horizontal: screenPaddingHorizontal,
  );

  /// Card padding (16px all sides)
  static const cardPaddingInsets = EdgeInsets.all(cardPadding);

  /// Small padding (8px all sides)
  static const smallPadding = EdgeInsets.all(space8);

  /// Medium padding (16px all sides)
  static const mediumPadding = EdgeInsets.all(space16);

  /// Large padding (24px all sides)
  static const largePadding = EdgeInsets.all(space24);

  /// Distance between title and details (16px)
  static const titleToDetailsSpacing = SizedBox(height: space16);

  /// Distance between sections (24px)
  static const sectionSpacing = SizedBox(height: space24);

  /// Small vertical spacing (8px)
  static const smallVerticalSpacing = SizedBox(height: space8);

  /// Medium vertical spacing (16px)
  static const mediumVerticalSpacing = SizedBox(height: space16);

  /// Small horizontal spacing (8px)
  static const smallHorizontalSpacing = SizedBox(width: space8);

  /// Medium horizontal spacing (16px)
  static const mediumHorizontalSpacing = SizedBox(width: space16);
}
