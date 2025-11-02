import 'package:flutter/material.dart';

// import '../controllers/verify_controller.dart';
import '../widgets/auth_layout.dart';
import '../widgets/verify_form.dart';

/// Only responsible for composing AuthLayout + VerifyForm
/// Follows single responsibility principle
class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      title: "Verify your Phone number",
      subtitle: "Enter the 4-digit OTP sent to +963 99554432",
      child: VerifyForm(),
    );
  }
}
