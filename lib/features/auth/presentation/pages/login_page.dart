import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../l10n/app_localizations.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [_buildHeader(), _buildFormCard(context, l10n)]),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5F8D7D), Color(0xFF7BA598), Color(0xFF9CB5A8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status bar space
          SizedBox(height: 20),

          Text(
            'Log in to your Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Welcome back! Log in to continue',
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 150, 33, 33),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Phone Number Field
          _buildPhoneField(l10n),

          SizedBox(height: 16),

          // Password Field
          _buildPasswordField(l10n),

          SizedBox(height: 24),

          // Login Button
          _buildLoginButton(),

          SizedBox(height: 16),

          // Forgot Password
          _buildForgotPassword(),

          SizedBox(height: 24),

          // Divider
          _buildDivider(),

          SizedBox(height: 24),

          // Become Provider Button
          _buildProviderButton(),

          SizedBox(height: 20),

          // Register Link
          _buildRegisterLink(),
        ],
      ),
    );
  }

  Widget _buildPhoneField(AppLocalizations l10n) {
    return TextField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: l10n.phone,
        hintText: 'Write Your Phone Number',
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, color: Color(0xFFFF6F00), size: 20),
              SizedBox(width: 8),
              Text(
                '+963',
                style: TextStyle(
                  color: Color(0xFFFF6F00),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Container(height: 24, width: 1, color: Colors.grey[300]),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFF6F00)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFF6F00).withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFF6F00), width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return Obx(
      () => TextField(
        controller: controller.passwordController,
        obscureText: !controller.isPasswordVisible.value,
        decoration: InputDecoration(
          labelText: l10n.password,
          hintText: 'Write Password...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.lock, color: Color(0xFFFF6F00), size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey[400],
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFFF6F00)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFFF6F00).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFFF6F00), width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3D5A4F),
            disabledBackgroundColor: Color(0xFF3D5A4F).withOpacity(0.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: controller.goToForgotPassword,
        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Color(0xFFFF6F00), fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or Enter as a Guest',
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
      ],
    );
  }

  Widget _buildProviderButton() {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          // Navigate to provider registration
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFFFF6F00), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Become a Provider',
          style: TextStyle(
            color: Color(0xFFFF6F00),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        GestureDetector(
          onTap: controller.goToRegister,
          child: Text(
            'Click here',
            style: TextStyle(color: Color(0xFFFF6F00), fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
