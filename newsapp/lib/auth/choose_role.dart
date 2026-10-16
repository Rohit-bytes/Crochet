import 'package:TrustLens/auth/custom_widgets/custom_role_select.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/auth/splash_screen.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/app_text.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseRole extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return GetBuilder<SplashController>(
          builder: (splashController) {
            return Scaffold(
              backgroundColor: ColorPalette.background,
              body: Stack(
                children: [
                  Positioned(top: 200, left: -80, child: customsquare(35)),
                  Positioned(top: 200, right: -80, child: customsquare(-35)),
                  Positioned(top: 600, left: -50, child: customsquare(50)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Welcome to ',
                                  style: TextStyle(
                                    fontSize: 30.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppText.appname,
                                      style: TextStyle(
                                        fontSize: 35.w,
                                        color: ColorPalette.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CustomText(
                                "choose your role to continue",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          CustomRoleSelect(
                            isstudent: false,
                            imagePath: "assets/teacher.png",
                            onPressed: () {
                              authController.changeIsStudent(false);
                              Get.offAllNamed(AppRoutes.teacherlogin);
                            },
                            subtitle:
                                "Take attendance, manage classes and more",
                            title: "I am a Teacher",
                          ),
                          SizedBox(height: 10.h),
                          CustomRoleSelect(
                            isstudent: true,
                            imagePath: "assets/student.png",
                            onPressed: () {
                              authController.changeIsStudent(true);
                              Get.offAllNamed(AppRoutes.teacherlogin);
                            },
                            subtitle: "View your attendance and stay updated",
                            title: "I am a Student",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
