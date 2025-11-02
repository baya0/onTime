import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/assets.gen.dart';
import '../controllers/login_controller.dart';

/// Login form widget - contains all login-specific form fields and actions
/// Separated from LoginPage to follow single responsibility principle
class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPhoneField(),
          SizedBox(height: AppSpacing.space24),
          _buildPasswordField(),
          SizedBox(height: AppSpacing.space24),
          _buildLoginButton(),
          SizedBox(height: AppSpacing.space12),
          _buildForgotPasswordButton(),
          SizedBox(height: AppSpacing.space12),
          _buildDivider(),
          SizedBox(height: AppSpacing.space32),
          _buildBecomeProviderButton(),
          SizedBox(height: AppSpacing.space16),
          _buildRegisterSection(),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return CustomTextField(
      controller: controller.phoneController,
      focusNode: controller.phoneFocusNode,
      hintText: tr(LocaleKeys.write_phone_number),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      prefixIcon: Container(
        padding: EdgeInsets.all(AppSpacing.space12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.space8,
                vertical: AppSpacing.space4,
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.icons.ui.phoneRing.svg(
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '+963',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.orange400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSpacing.space8),
            Container(height: 24, width: 1, color: AppColors.grayLessDark),
          ],
        ),
      ),
      validator: controller.validatePhone,
      onSubmitted: (_) {
        controller.passwordFocusNode.requestFocus();
      },
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: controller.passwordController,
      focusNode: controller.passwordFocusNode,
      hintText: tr(LocaleKeys.write_password),
      obscureTextRx: controller.obscurePassword,
      isPassword: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      prefixIcon: Container(
        padding: EdgeInsets.all(AppSpacing.space12),
        child: Assets.icons.auth.lock.svg(
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
        ),
      ),
      validator: controller.validatePassword,
      onSubmitted: (_) {
        controller.login();
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: controller.goToForgotPassword,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space4),
        ),
        child: Text(
          tr(LocaleKeys.forgot_password),
          style: AppTextStyles.body.copyWith(color: AppColors.orange400),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: tr(LocaleKeys.login),
      onPressed: controller.login,
      isLoadingRx: controller.isLoading,
      type: ButtonType.primary,
      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.grayLessDark, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.space16),
          child: Text(
            tr(LocaleKeys.or_enter_as_guest),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.green900,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.grayLessDark, thickness: 1)),
      ],
    );
  }

  Widget _buildBecomeProviderButton() {
    return CustomButton(
      text: tr(LocaleKeys.become_a_provider),
      onPressed: controller.becomeProvider,
      type: ButtonType.outlined,
      borderColor: AppColors.orange400,
      textColor: AppColors.orange400,
      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.orange400,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget _buildRegisterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(LocaleKeys.dont_have_account),
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
        TextButton(
          onPressed: controller.goToRegister,
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: AppSpacing.space4)),
          child: Text(
            tr(LocaleKeys.click_here),
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.orange400,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
