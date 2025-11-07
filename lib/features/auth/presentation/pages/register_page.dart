import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../controllers/register_controller.dart';
import '../widgets/auth_layout.dart';
import '../widgets/register_form.dart';

/// Register page following the same pattern as LoginPage
class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showBackButton: true,
      title: tr(LocaleKeys.create_account),
      subtitle: tr(LocaleKeys.sign_up_to_create_account),
      child: const RegisterForm(),
    );
  }
}
