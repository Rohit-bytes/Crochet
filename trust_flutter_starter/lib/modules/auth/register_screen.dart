import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    final wide = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: wide ? 430 : 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Join Trust',
                    style: TextStyle(fontSize: 30,
                      fontWeight: FontWeight.bold, color: AppColors.text)),
                  const SizedBox(height: 8),
                  const Text('Create an account to explore news transparently.',
                    style: TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 30),
                  const Text('Full name'),
                  const SizedBox(height: 8),
                  CustomTextField(hint: 'Your name',
                    controller: c.nameController,
                    prefixIcon: const Icon(Icons.person_outline)),
                  const SizedBox(height: 18),
                  const Text('Email'),
                  const SizedBox(height: 8),
                  CustomTextField(hint: 'you@example.com',
                    controller: c.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(height: 18),
                  const Text('Password'),
                  const SizedBox(height: 8),
                  CustomTextField(hint: 'At least 6 characters',
                    controller: c.passwordController,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline)),
                  const SizedBox(height: 26),
                  Obx(() => CustomButton(
                    title: 'Create account',
                    loading: c.isLoading.value,
                    onTap: c.register,
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
