import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AuthController());
    final wide = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: wide ? 430 : 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/applogo.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text('Welcome back',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text)),
                  const SizedBox(height: 8),
                  const Text('Sign in and see the story behind the story.',
                      style: TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 32),
                  const Text('Email'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: 'Enter Your Email',
                    controller: c.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 18),
                  const Text('Password'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: 'Enter password',
                    controller: c.passwordController,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 26),
                  Obx(() => CustomButton(
                        title: AppText.login,
                        loading: c.isLoading.value,
                        onTap: c.login,
                      )),
                  const SizedBox(height: 18),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: const Text("Don't have an account? Create one"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
