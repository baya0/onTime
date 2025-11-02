import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
// import '../controllers/verify_controller.dart'; // You'll need to create this

/// Verify form widget - contains all verification-specific form fields and actions
/// Separated from VerifyPage to follow single responsibility principle
class VerifyForm extends StatelessWidget {
  const VerifyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildOTPFields(),
        SizedBox(height: AppSpacing.space16),
        _buildTimerSection(),
        SizedBox(height: AppSpacing.space8),
        _buildResendSection(),
        SizedBox(height: AppSpacing.space32),
        _buildVerifyButton(),
      ],
    );
  }

  /// 4 OTP input boxes
  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) => _buildOTPBox(index)),
    );
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grayLeastDark, width: 1.5),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: AppTextStyles.h2Bold.copyWith(color: AppColors.textPrimary),
          decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
          onChanged: (value) {
            if (value.isNotEmpty) {
              // Move to next field
              FocusScope.of(Get.context!).nextFocus();
            }
          },
        ),
      ),
    );
  }

  /// Timer countdown display
  Widget _buildTimerSection() {
    return Center(
      child: Text(
        "Didn't receive code? 2:00:55",
        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  /// Resend code button
  Widget _buildResendSection() {
    return Center(
      child: TextButton(
        onPressed: () {
          // TODO: Implement resend code logic
        },
        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: AppSpacing.space8)),
        child: Text(
          "Resend Code",
          style: AppTextStyles.bodyBold.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  /// Verify button
  Widget _buildVerifyButton() {
    return CustomButton(
      text: "Verify",
      onPressed: () {
        // TODO: Implement verification logic
      },
      type: ButtonType.primary,
      height: 56,
    );
  }
}
