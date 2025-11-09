import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/verify_controller.dart';
import '../widgets/auth_layout.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Verify your Phone number",
      subtitle: _buildSubtitle(),
      showBackButton: true,
      child: _buildVerifyForm(),
    );
  }

  String _buildSubtitle() {
    final phone = controller.fullPhoneNumber ?? controller.cleanPhone ?? '';
    return "Enter the 4-digit OTP sent to $phone";
  }

  Widget _buildVerifyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPinput(),
        SizedBox(height: AppSpacing.space24),
        _buildResendSection(),
        SizedBox(height: AppSpacing.space32),
        _buildVerifyButton(),
      ],
    );
  }

  Widget _buildPinput() {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: AppTextStyles.h2.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grayLessDark, width: 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.orange400, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.orange50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.orange400, width: 1),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error, width: 2),
      ),
    );

    return Pinput(
      controller: controller.otpController,
      focusNode: controller.otpFocusNode,
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      cursor: Container(
        width: 2,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.orange400,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      validator: controller.validateOTP,
      onCompleted: (pin) {
        debugPrint('📱 PIN completed: $pin');
        // Auto-submit when complete
        controller.verifyCode();
      },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildResendSection() {
    return Obx(() {
      final cooldown = controller.resendCooldown.value;
      final canResend = controller.canResend.value;

      return Column(
        children: [
          // Timer text
          if (!canResend)
            Text(
              'Didn\'t receive code? ${_formatTime(cooldown)}',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),

          // Resend button
          TextButton(
            onPressed: canResend ? controller.resendCode : null,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.space8,
                vertical: AppSpacing.space4,
              ),
            ),
            child: Text(
              tr(LocaleKeys.resend_code),
              style: AppTextStyles.bodyBold.copyWith(
                color: canResend ? AppColors.orange400 : AppColors.textSecondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      );
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Widget _buildVerifyButton() {
    return Obx(
      () => CustomButton(
        text: "Verify",
        onPressed: controller.verifyCode,
        isLoadingRx: controller.isLoading,
        type: ButtonType.primary,
        textStyle: AppTextStyles.body.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
