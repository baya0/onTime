import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/auth_layout.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showBackButton: true,
      title: 'sign_up'.tr,
      subtitle: 'sign_up_to_create_account'.tr,
      child: RegisterForm(),
    );
  }
}
