import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/assets.gen.dart';
import '../controllers/login_controller.dart';

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
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        controller.onPhoneNumberChanged(number);
      },
      onInputValidated: (bool isValid) {
        debugPrint('📱 Phone valid: $isValid');
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        useEmoji: true,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 20,
        trailingSpace: false,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      initialValue: PhoneNumber(isoCode: 'SY'),
      formatInput: true,
      keyboardType: TextInputType.phone,
      inputDecoration: InputDecoration(
        hintText: tr(LocaleKeys.write_phone_number),
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space16,
        ),
        // ✅ Styled borders like your design
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grayLessDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grayLessDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.orange400, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      selectorTextStyle: AppTextStyles.body.copyWith(
        color: AppColors.orange400,
        fontWeight: FontWeight.bold,
      ),
      textStyle: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      validator: controller.validatePhone,
      spaceBetweenSelectorAndTextField: 8,
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
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Expanded(child: Divider(color: AppColors.grayLessDark, thickness: 1)),
      ],
    );
  }

  Widget _buildBecomeProviderButton() {
    return OutlinedButton(
      onPressed: controller.becomeProvider,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.space16),
        side: BorderSide(color: AppColors.orange400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        tr(LocaleKeys.become_a_provider),
        style: AppTextStyles.body.copyWith(color: AppColors.orange400, fontWeight: FontWeight.w500),
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
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: AppSpacing.space8)),
          child: Text(
            tr(LocaleKeys.click_here),
            style: AppTextStyles.body.copyWith(
              color: AppColors.orange400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
