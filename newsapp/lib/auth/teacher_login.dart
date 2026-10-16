import 'package:TrustLens/auth/custom_widgets/custom_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_remember_me.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text_field.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,

          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  authController.toggleIsStudent();
                },
                child: Text(
                  "Switch to ${authController.isStudent == true ? "teacher" : "student"}",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
            toolbarHeight: 50.h,
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorPalette.background,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCircleButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.chooserole);
                },
                icon: Icons.keyboard_arrow_left_rounded,
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Image.asset("assets/school.png"),

                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      CustomText(
                        authController.isStudent == true
                            ? "Student Login"
                            : "Teacher Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.w,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      CustomText(
                        "Access your classes and manage\nattendance",
                        style: TextStyle(fontSize: 16.w),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  CustomTextField(
                    errorText: authController.emailError,
                    controller: emailController,
                    hint: "Email Address",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 10.h),

                  CustomTextField(
                    errorText: authController.passwordError,
                    controller: passwordController,
                    hint: "Password",
                    prefixIcon: Icons.lock_outline,
                    isPassword: authController.isobsecure,

                    suffixicon: GestureDetector(
                      onTap: () {
                        authController.isobsecurecheck();
                      },
                      child: Icon(
                        authController.isobsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7D899F),
                        size: 22,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  const CustomRememberMe(),

                  SizedBox(height: 10.h),

                  authController.isLoading == true
                      ? CircularProgressIndicator()
                      : CustomButton(
                          title: "Log In",
                          callback: () {
                            authController.loginCheck(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.register);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an Account? ",
                        style: TextStyle(color: ColorPalette.textSecondary),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(color: ColorPalette.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
