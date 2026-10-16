import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text_field.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterStudentManually extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newClass = Get.arguments;

    // String course = newClass['course'];
    // String semester = newClass['semester'];
    String className = newClass['class_name'];
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(title: ""),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CustomText("Add Student Manually"),
                  Text("Enter student details to add to ${className}"),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: "Enrollment Number",
                    prefixIcon: Icons.numbers,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(hint: "Full Name", prefixIcon: Icons.person),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: "Email",
                    prefixIcon: Icons.email_outlined,
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonTwo(
                textColor: ColorPalette.white,
                color: ColorPalette.primary,
                title: "Add Student",
                callback: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
