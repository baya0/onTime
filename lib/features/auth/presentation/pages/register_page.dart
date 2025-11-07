import 'package:flutter/material.dart';

import '../widgets/auth_layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(showBackButton: true, child: RegisterForm());
  }
}
