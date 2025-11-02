// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';
import '../style/app_dimensions.dart';
import '../style/app_text_styles.dart';

enum ButtonType {
  primary, // Filled button with primary color
  secondary, // Filled button with secondary color
  outlined, // Outlined button
  text, // Text button without background
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final RxBool? isLoadingRx; // GetX reactive loading state
  final bool isFullWidth;
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoadingRx,
    this.isFullWidth = true,
    this.width,
    this.height,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final loadingState = isLoadingRx ?? false.obs;

    return Obx(() {
      final bool isDisabled = onPressed == null || loadingState.value;

      return SizedBox(
        width: isFullWidth ? double.infinity : width,
        height: height ?? 52,
        child: _buildButton(isDisabled, loadingState.value),
      );
    });
  }

  Widget _buildButton(bool isDisabled, bool isLoading) {
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(isDisabled, isLoading);
      case ButtonType.secondary:
        return _buildSecondaryButton(isDisabled, isLoading);
      case ButtonType.outlined:
        return _buildOutlinedButton(isDisabled, isLoading);
      case ButtonType.text:
        return _buildTextButton(isDisabled, isLoading);
    }
  }

  Widget _buildPrimaryButton(bool isDisabled, bool isLoading) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style:
          ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.green500,
            foregroundColor: textColor ?? AppColors.white,
            disabledBackgroundColor: AppColors.grayLessDark,
            disabledForegroundColor: AppColors.textDisabled,
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: AppSpacing.space24, vertical: AppSpacing.space16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.borderRadiusSmall),
            ),
            elevation: 0, // remove old raised effect
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) return AppColors.green500.withOpacity(0.1);
              if (states.contains(WidgetState.hovered)) return AppColors.green500.withOpacity(0.05);
              return null;
            }),
            shadowColor: WidgetStateProperty.all(Colors.transparent), // remove shadow
          ),
      child: _buildButtonContent(isLoading),
    );
  }

  Widget _buildSecondaryButton(bool isDisabled, bool isLoading) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style:
          ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.grayLessDark,
            foregroundColor: textColor ?? AppColors.white,
            disabledBackgroundColor: AppColors.grayLessDark,
            disabledForegroundColor: AppColors.textDisabled,
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: AppSpacing.space24, vertical: AppSpacing.space16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.borderRadiusSmall),
            ),
            elevation: 0,
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.grayLessDark.withOpacity(0.1);
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.grayLessDark.withOpacity(0.05);
              }
              return null;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
      child: _buildButtonContent(isLoading),
    );
  }

  // OUTLINED BUTTON
  Widget _buildOutlinedButton(bool isDisabled, bool isLoading) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style:
          OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.orange300,
            disabledForegroundColor: AppColors.textDisabled,
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: AppSpacing.space24, vertical: AppSpacing.space16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.borderRadiusSmall),
            ),
            side: BorderSide(
              color: isDisabled ? AppColors.grayLessDark : (borderColor ?? AppColors.primary),
              width: 1.5,
            ),
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.primary.withOpacity(0.05);
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primary.withOpacity(0.02);
              }
              return null;
            }),
          ),
      child: _buildButtonContent(isLoading),
    );
  }

  Widget _buildTextButton(bool isDisabled, bool isLoading) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style:
          TextButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primary,
            disabledForegroundColor: AppColors.textDisabled,
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: AppSpacing.space16, vertical: AppSpacing.space8),
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.primary.withOpacity(0.05);
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primary.withOpacity(0.02);
              }
              return null;
            }),
          ),
      child: _buildButtonContent(isLoading),
    );
  }

  Widget _buildButtonContent(bool isLoading) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.outlined || type == ButtonType.text
                ? AppColors.primary
                : AppColors.white,
          ),
        ),
      );
    }

    final TextStyle finalTextStyle =
        textStyle ??
        AppTextStyles.bodyBold.copyWith(
          color:
              textColor ??
              (type == ButtonType.primary || type == ButtonType.secondary
                  ? AppColors.white
                  : AppColors.primary),
        );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: AppSpacing.space8),
          Flexible(
            child: Text(text, style: finalTextStyle, overflow: TextOverflow.ellipsis),
          ),
        ],
      );
    }

    return Text(text, style: finalTextStyle, overflow: TextOverflow.ellipsis);
  }
}
