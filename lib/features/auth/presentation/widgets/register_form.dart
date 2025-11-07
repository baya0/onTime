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
import '../controllers/register_controller.dart';

class RegisterForm extends GetView<RegisterController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNameFields(),
          SizedBox(height: AppSpacing.space16),
          _buildPhoneField(),
          SizedBox(height: AppSpacing.space16),
          _buildLocationFields(),
          SizedBox(height: AppSpacing.space16),
          _buildPasswordField(),
          SizedBox(height: AppSpacing.space16),
          _buildConfirmPasswordField(),
          SizedBox(height: AppSpacing.space16),
          _buildTermsCheckbox(),
          SizedBox(height: AppSpacing.space24),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: controller.firstNameController,
            focusNode: controller.firstNameFocusNode,
            hintText: tr(LocaleKeys.first_name),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: Container(
              padding: EdgeInsets.all(AppSpacing.space12),
              child: Assets.icons.auth.user.svg(
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
              ),
            ),
            validator: controller.validateFirstName,
            onSubmitted: (_) => controller.lastNameFocusNode.requestFocus(),
          ),
        ),
        SizedBox(width: AppSpacing.space12),
        Expanded(
          child: CustomTextField(
            controller: controller.lastNameController,
            focusNode: controller.lastNameFocusNode,
            hintText: tr(LocaleKeys.last_name),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: Container(
              padding: EdgeInsets.all(AppSpacing.space12),
              child: Assets.icons.auth.user.svg(
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
              ),
            ),
            validator: controller.validateLastName,
            onSubmitted: (_) => controller.phoneFocusNode.requestFocus(),
          ),
        ),
      ],
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
      onSubmitted: (_) => controller.cityFocusNode.requestFocus(),
    );
  }

  Widget _buildLocationFields() {
    return Row(
      children: [
        // State dropdown (placeholder)
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Implement state picker
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
                vertical: AppSpacing.space16,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                border: Border.all(color: AppColors.grayLessDark),
              ),
              child: Row(
                children: [
                  Assets.icons.auth.state.svg(
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
                  ),
                  SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Text(
                      tr(LocaleKeys.state),
                      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.orange400, size: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.space12),
        // City dropdown
        Expanded(
          child: Obx(
            () => GestureDetector(
              onTap: () => _showCityPicker(Get.context!),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                  vertical: AppSpacing.space16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                  border: Border.all(color: AppColors.grayLessDark),
                ),
                child: Row(
                  children: [
                    Assets.icons.auth.city.svg(
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
                    ),
                    SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Text(
                        controller.selectedCityName.value ?? tr(LocaleKeys.city),
                        style: AppTextStyles.body.copyWith(
                          color: controller.selectedCityName.value == null
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.orange400, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
      textInputAction: TextInputAction.next,
      prefixIcon: Container(
        padding: EdgeInsets.all(AppSpacing.space12),
        child: Assets.icons.auth.lock.svg(
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(AppColors.orange400, BlendMode.srcIn),
        ),
      ),
      validator: controller.validatePassword,
      onSubmitted: (_) => controller.confirmPasswordFocusNode.requestFocus(),
    );
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: controller.confirmPasswordController,
      focusNode: controller.confirmPasswordFocusNode,
      hintText: tr(LocaleKeys.confirm_password),
      obscureTextRx: controller.obscureConfirmPassword,
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
      validator: controller.validateConfirmPassword,
      onSubmitted: (_) => controller.register(),
    );
  }

  Widget _buildTermsCheckbox() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.agreeToTerms.value,
              onChanged: (value) => controller.agreeToTerms.value = value ?? false,
              activeColor: AppColors.orange400,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
          SizedBox(width: AppSpacing.space8),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.agreeToTerms.value = !controller.agreeToTerms.value,
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  children: [
                    TextSpan(text: tr(LocaleKeys.i_agree_with)),
                    TextSpan(text: ' '),
                    TextSpan(
                      text: tr(LocaleKeys.terms_and_policies),
                      style: TextStyle(
                        color: AppColors.orange400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return CustomButton(
      text: tr(LocaleKeys.sign_up),
      onPressed: controller.register,
      isLoadingRx: controller.isLoading,
      type: ButtonType.primary,
      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  void _showCityPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Obx(() {
          if (controller.isLoadingCities.value) {
            return SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator(color: AppColors.orange400)),
            );
          }

          if (controller.cities.isEmpty) {
            return SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  tr(LocaleKeys.no_cities_available),
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(AppSpacing.space16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grayLessDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: AppSpacing.space16),
                Text(tr(LocaleKeys.select_city), style: AppTextStyles.h3Bold),
                SizedBox(height: AppSpacing.space16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cities.length,
                    itemBuilder: (context, index) {
                      final city = controller.cities[index];
                      return ListTile(
                        title: Text(city['name'], style: AppTextStyles.body),
                        onTap: () {
                          controller.selectCity(city['id'], city['name']);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
