import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/add_class/attendance_tab.dart';
import 'package:TrustLens/view/add_class/student_tab.dart';
import 'package:TrustLens/view/add_subject/custom_widgets/subject_tab.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_tabbar.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UploadExcelSheet extends StatelessWidget {
  const UploadExcelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newClass = Get.arguments;

    String id = newClass['id'];
    String semester = newClass['semester'];
    String className = newClass['class_name'];
    print("id " + id);
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "",
            onBack: () {
              homeController.tabchange(0);
              Get.back();
            },
          ),
          backgroundColor: ColorPalette.background,

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                // ================= CLASS HEADER =================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          ColorPalette.background,
                          Colors.white,
                          0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.school_sharp,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            className.toString(),
                            style: TextStyle(
                              color: ColorPalette.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          Text(
                            semester.toString(),
                            style: TextStyle(
                              color: ColorPalette.textSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // ================= TAB BAR =================
                ClassTabBar(
                  selectedIndex: homeController.tabIndex,
                  onTabChanged: (index) {
                    homeController.tabchange(index);
                  },
                ),

                // ================= TAB CONTENT =================
                _buildTab(homeController, newClass),
              ],
            ),
          ),
          floatingActionButton:
              homeController.students.isNotEmpty && homeController.tabIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.enterStudentManually,
                      arguments: newClass,
                    );
                  },
                  backgroundColor: ColorPalette.primary,
                  child: Icon(Icons.add, color: ColorPalette.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(50),
                  ),
                )
              : null,

          bottomNavigationBar: homeController.tabIndex == 1
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SafeArea(
                    child: CustomButtonTwo(
                      title: " Add Subject",
                      prefixwidget: Icon(
                        Icons.add,
                        color: ColorPalette.primary,
                      ),
                      color: ColorPalette.white,
                      textColor: ColorPalette.primary,

                      radius: 12,
                      callback: () {
                        Get.toNamed(
                          AppRoutes.enterSubjectManually,
                          arguments: newClass,
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(),
        );
      },
    );
  }

  Widget _buildTab(
    HomeController homeController,
    Map<String, dynamic> newClass,
  ) {
    switch (homeController.tabIndex) {
      // STUDENTS
      case 0:
        return StudentTab(newclass: newClass);

      // SUBJECTS
      case 1:
        return SubjectTab(newclass: newClass);

      // ATTENDANCE
      case 2:
        return AttendanceTab(newClass: newClass);

      default:
        return StudentTab(newclass: newClass);
    }
  }
}
