import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _auth = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('Missing details', 'Enter your email and password.');
      return;
    }
    try {
      isLoading.value = true;
      await _auth.login(emailController.text, passwordController.text);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Login failed', _message(e));
      print(_message(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.length < 6) {
      Get.snackbar('Check details',
          'Enter your name, email and a password of at least 6 characters.');
      return;
    }
    try {
      isLoading.value = true;
      await _auth.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      if (_auth.currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar('Registration failed', _message(e));
    } finally {
      isLoading.value = false;
    }
  }

  String _message(Object error) =>
      error.toString().replaceFirst('Exception: ', '');

  @override
  void onClose() {
    // nameController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
