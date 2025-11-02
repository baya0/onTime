import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../generated/assets.gen.dart';
import '../style/app_colors.dart';
import '../style/app_dimensions.dart';
import '../style/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final RxBool? obscureTextRx; // For GetX reactive password visibility
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureTextRx,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.textInputAction,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Create local RxBool if not provided and isPassword is true
    final obscureText = obscureTextRx ?? (isPassword ? true.obs : false.obs);

    return Obx(
      () => TextFormField(
        controller: controller,
        obscureText: obscureText.value,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        enabled: enabled,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        textInputAction: textInputAction,
        readOnly: readOnly,
        onTap: onTap,
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
                  icon: obscureText.value
                      ? Assets.icons.auth.eyeOn.svg(
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                        )
                      : Assets.icons.auth.eyeOff.svg(
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                        ),

                  onPressed: () => obscureText.value = !obscureText.value,
                )
              : suffixIcon,
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.grayLessDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.grayLessDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            borderSide: BorderSide(color: AppColors.grayLessDark),
          ),
          hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          labelStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}
