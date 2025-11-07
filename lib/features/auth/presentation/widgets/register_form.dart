import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../generated/assets.gen.dart';
import '../controllers/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'sign_up_to_create_account'.tr,
          style: AppTextStyles.headingLargeBold.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 24),

        // First Name & Last Name Row
        Row(
          children: [
            Expanded(
              child: CustomAuthTextField(
                controller: controller.firstNameController,
                hintText: 'first_name'.tr,
                prefixIcon: SvgPicture.asset(Assets.icons.auth.user.path, width: 20, height: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomAuthTextField(
                controller: controller.lastNameController,
                hintText: 'last_name'.tr,
                prefixIcon: SvgPicture.asset(Assets.icons.auth.user.path, width: 20, height: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Phone Number
        CustomAuthTextField(
          controller: controller.phoneController,
          hintText: 'write_phone_number'.tr,
          keyboardType: TextInputType.phone,
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: AppColors.grayLight, width: 1)),
            ),
            child: Center(
              child: Text(
                '+963',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // State & City Row
        Row(
          children: [
            // State Dropdown (placeholder for now)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.bgSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.auth.state.path, width: 18, height: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'state'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // City Dropdown
            Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: () => _showCityPicker(context, controller),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.bgSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.icons.auth.city.path, width: 18, height: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.selectedCityName.value ?? 'city'.tr,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: controller.selectedCityName.value == null
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Password
        Obx(
          () => CustomAuthTextField(
            controller: controller.passwordController,
            hintText: 'write_password'.tr,
            isPassword: true,
            obscureText: controller.obscurePassword.value,
            prefixIcon: SvgPicture.asset(Assets.icons.auth.lock.path, width: 20, height: 20),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                controller.obscurePassword.value
                    ? Assets.icons.auth.eyeOff.path
                    : Assets.icons.auth.eyeOn.path,
                width: 20,
                height: 20,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Confirm Password
        Obx(
          () => CustomAuthTextField(
            controller: controller.confirmPasswordController,
            hintText: 'confirm_password'.tr,
            isPassword: true,
            obscureText: controller.obscureConfirmPassword.value,
            prefixIcon: SvgPicture.asset(Assets.icons.auth.lock.path, width: 20, height: 20),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                controller.obscureConfirmPassword.value
                    ? Assets.icons.auth.eyeOff.path
                    : Assets.icons.auth.eyeOn.path,
                width: 20,
                height: 20,
              ),
              onPressed: controller.toggleConfirmPasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Terms and Conditions Checkbox
        Obx(
          () => Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: controller.agreeToTerms.value,
                  onChanged: (value) {
                    controller.agreeToTerms.value = value ?? false;
                  },
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 8),
              Text('i_agree_with'.tr, style: AppTextStyles.bodySmall),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  // Navigate to terms page
                },
                child: Text(
                  'terms_and_policies'.tr,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Sign Up Button
        Obx(
          () => CustomAuthButton(
            text: 'sign_up'.tr,
            onPressed: controller.isLoading.value ? null : controller.register,
            isLoading: controller.isLoading.value,
          ),
        ),
      ],
    );
  }

  void _showCityPicker(BuildContext context, RegisterController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          if (controller.isLoadingCities.value) {
            return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
          }

          if (controller.cities.isEmpty) {
            return SizedBox(height: 300, child: Center(child: Text('no_cities_available'.tr)));
          }

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grayLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text('select_city'.tr, style: AppTextStyles.headingMediumBold),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cities.length,
                    itemBuilder: (context, index) {
                      final city = controller.cities[index];
                      return ListTile(
                        title: Text(city['name'], style: AppTextStyles.bodyMedium),
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
