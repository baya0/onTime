import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_layout.dart';
import '../widgets/login_form.dart';

/// Only responsible for composing AuthLayout + LoginForm
/// Follows single responsibility principle
class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: tr(LocaleKeys.login_to_account),
      subtitle: tr(LocaleKeys.welcome_back),
      child: const LoginForm(),
    );
  }
}
