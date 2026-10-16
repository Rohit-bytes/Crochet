import 'package:TrustLens/auth/custom_widgets/custom_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/add_class/class_widget.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClassAddSuccesfully extends StatelessWidget {
  const ClassAddSuccesfully({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newClass = Get.arguments;
    String id = newClass['id'];
    String course = newClass['course'];

    String semester = newClass['semester'];
    String className = newClass['class_name'];

    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,

          appBar: CustomAppBar(
            title: "",
            showBackButton: false,
            actions: [
              CustomCircleButton(
                icon: Icons.clear,
                iconsize: 22,
                onPressed: () {
                  Get.offAllNamed(AppRoutes.landingpage);
                },
              ),
            ],
            leadingwidget: SizedBox(),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),

                    Image.asset("assets/greentick.png", height: 100.h),

                    SizedBox(height: 10.h),

                    Text(
                      "Class Created\nSuccessfully!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: ColorPalette.black,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Now add students to this class\n"
                      "to start taking attendance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 25.h),

                    ClassWidget(courseName: course),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    title: "Add Student Now",
                    callback: () {
                      Get.toNamed(
                        AppRoutes.uploadexcelsheet,
                        arguments: {
                          'id': id,
                          'semester': semester,
                          'class_name': className,
                        },
                      );
                    },
                  ),

                  SizedBox(height: 10.h),

                  CustomButtonTwo(
                    title: "Skip For Now",
                    callback: () {
                      Get.offAllNamed(AppRoutes.landingpage);
                    },
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
