import 'package:TrustLens/auth/custom_widgets/custom_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/add_class/custom_student_tile.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentTab extends StatelessWidget {
  final Map<String, dynamic> newclass;
  const new({super.key, required this.newclass});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return GetBuilder<HomeController>(
          builder: (homeController) {
            return homeController.students.isNotEmpty
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await homeController.fetchAllStudent();
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: homeController.students.length,
                        itemBuilder: (context, index) {
                          final student = homeController.students[index];
                          print(authController.userDetails!.gender);
                          return StudentTile(
                            enrollmentNo:
                                student["enrollment_number"] ?? "No enrollment",
                            name: student["name"] ?? "no name found",
                            email: student["email"] ?? "no email found",
                            imageUrl: student["gender"] == "Male"
                                ? "assets/maleimage.png"
                                : "assets/femaleuser.png",
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.groups,
                          size: 300,
                          color: ColorPalette.primaryLight,
                        ),
                        Text(
                          "No Student added yet",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: ColorPalette.black,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                          "Add students to start taking attendance\nfor this class",
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          title: "Upload Excel Sheet",
                          callback: () {
                            final homeController = Get.find<HomeController>();
                            homeController.pickexcelfile();
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomButtonTwo(
                          title: "Manual Entry",
                          callback: () {
                            Get.toNamed(
                              AppRoutes.enterStudentManually,
                              arguments: newclass,
                            );
                          },
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
