import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontime/generated/locale_keys.g.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ResponsiveHelper.scaleHeight(80)),
                  _buildHeader(),
                  SizedBox(height: ResponsiveHelper.scaleHeight(40)),
                  _buildLoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      height: ResponsiveHelper.screenHeight * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondary.withOpacity(0.8), AppColors.background],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.login_to_account),
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
          tr(LocaleKeys.welcome_back), // CHANGED
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

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.space24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPhoneField(),
            SizedBox(height: AppSpacing.space16),
            _buildPasswordField(),
            SizedBox(height: AppSpacing.space8),
            _buildForgotPasswordButton(),
            SizedBox(height: AppSpacing.space24),
            _buildLoginButton(),
            SizedBox(height: AppSpacing.space24),
            _buildDivider(),
            SizedBox(height: AppSpacing.space24),
            _buildBecomeProviderButton(),
            SizedBox(height: AppSpacing.space16),
            _buildRegisterSection(),
          ],
        ),
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
              decoration: BoxDecoration(
                color: AppColors.orange50,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
              ),
              child: Text(
                '+963',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.space8),
            Container(height: 24, width: 1, color: AppColors.grayLeastDark),
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
    return Obx(
      () => CustomTextField(
        controller: controller.passwordController,
        focusNode: controller.passwordFocusNode,
        hintText: tr(LocaleKeys.write_password),
        obscureTextRx: controller.obscurePassword,
        isPassword: true,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.textSecondary),
        validator: controller.validatePassword,
        onSubmitted: (_) {
          controller.login();
        },
      ),
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
          style: AppTextStyles.body.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
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
      height: 56,
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.grayLeastDark, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.space16),
          child: Text(
            tr(LocaleKeys.or_enter_as_guest),
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Expanded(child: Divider(color: AppColors.grayLeastDark, thickness: 1)),
      ],
    );
  }

  Widget _buildBecomeProviderButton() {
    return CustomButton(
      text: tr(LocaleKeys.become_a_provider),
      onPressed: controller.becomeProvider,
      type: ButtonType.outlined,
      height: 52,
      borderColor: AppColors.primary,
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
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
