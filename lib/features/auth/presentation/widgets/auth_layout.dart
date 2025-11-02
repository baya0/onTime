import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

/// Reusable authentication layout wrapper for all auth pages
/// Provides consistent background, header, and card container
class AuthLayout extends StatelessWidget {
  /// Main title displayed in the header (e.g., "Log in to your Account")
  final String title;

  /// Subtitle displayed below the title (e.g., "Welcome back! Log in to continue")
  final String subtitle;

  /// The form content to display inside the white card
  final Widget child;

  /// Optional: Custom background image path
  /// Defaults to 'assets/images/auth-background.webp'
  final String? backgroundImage;

  /// Optional: Custom background height ratio (0.0 to 1.0)
  /// Defaults to 0.3 (30% of screen height)
  final double backgroundHeightRatio;

  /// Optional: Spacing between header and card
  /// Defaults to ResponsiveHelper.scaleHeight(30)
  final double? headerToCardSpacing;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.backgroundImage,
    this.backgroundHeightRatio = 0.3,
    this.headerToCardSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header on top of background
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPaddingHorizontal,
                      vertical: ResponsiveHelper.scaleHeight(10),
                    ),
                    child: _buildHeader(),
                  ),
                  SizedBox(height: headerToCardSpacing ?? ResponsiveHelper.scaleHeight(20)),
                  // White container with rounded top corners
                  _buildCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Background image with gradient overlay
  Widget _buildBackgroundImage() {
    return Container(
      height: ResponsiveHelper.screenHeight * backgroundHeightRatio,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondary, AppColors.secondary],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage ?? 'assets/images/auth-background.webp'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
      ),
    );
  }

  /// Header section with title and subtitle
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h1Bold.copyWith(
            color: AppColors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.space8),
        Text(
          subtitle,
          style: AppTextStyles.body.copyWith(
            color: AppColors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 37, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.borderRadiusLarge),
          topRight: Radius.circular(AppSpacing.borderRadiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: child,
    );
  }
}
