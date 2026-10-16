import 'package:TrustLens/auth/custom_widgets/custom_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text_field.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_dropdown.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AddClassess extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        print(homeController.courses);
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(
            title: "Add New Class",
            onBack: () {
              homeController.finalcourseName = "";
              homeController.finalsemesterName = "";
              homeController.classNamecontrol.clear();
              Get.back();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Center(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/addClass.png", height: 100.h),
                        Text(
                          textAlign: TextAlign.center,
                          "Create a new class and add students\nto start taking attendance.",
                        ),

                        SizedBox(height: 10.h),
                        CustomDropdown(
                          errorText: homeController.courseError,
                          label: 'Course',
                          hintText:
                              homeController.finalcourseName == null ||
                                  homeController.finalcourseName == ""
                              ? 'Select Course'
                              : '${homeController.finalcourseName}',
                          leadingIcon: Icons.school_outlined,

                          items: homeController.courses.map((course) {
                            return DropdownMenuEntry<String>(
                              value: course['id'].toString() ?? '',
                              label: '${course['course_name'] ?? ''} ',
                            );
                          }).toList(),
                          onSelected: (value) {
                            if (value == null) return;

                            final selectedCourse = homeController.courses
                                .firstWhere(
                                  (course) => course['id'].toString() == value,
                                );

                            homeController.finalcourseName =
                                selectedCourse['course_name'].toString();
                            homeController.courseError = null;
                            homeController.update();
                            print("Selected Course ID: $value");
                            print(
                              "Selected Course Name: ${homeController.finalcourseName}",
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomDropdown(
                          errorText: homeController.semesterError,
                          label: 'Semester',
                          hintText:
                              homeController.finalsemesterName == null ||
                                  homeController.finalsemesterName == ""
                              ? 'Select Semester'
                              : '${homeController.finalsemesterName}',
                          leadingIcon: Icons.book_outlined,

                          items: homeController.semester.map((semester) {
                            return DropdownMenuEntry<String>(
                              value: semester['id'].toString() ?? '',
                              label: '${semester['Name'] ?? 'not found'} ',
                            );
                          }).toList(),

                          onSelected: (value) {
                            if (value == null) return;

                            final selectedSemester = homeController.semester
                                .firstWhere(
                                  (semester) =>
                                      semester['id'].toString() == value,
                                );

                            homeController.finalsemesterName =
                                selectedSemester['Name'].toString();
                            homeController.semesterError = null;
                            homeController.update();
                            print("Selected Semester ID: $value");
                            print(
                              "Selected Semester Name: ${homeController.finalsemesterName}",
                            );
                          },
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            Text(
                              "Class Name",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF17213A),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        CustomTextField(
                          errorText: homeController.classNameError,
                          controller: homeController.classNamecontrol,
                          hint: "e.g. Mca- Sem 5-A",
                          prefixIcon: Icons.text_fields_sharp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: homeController.isloading == true
                  ? Container(
                      height: 30.h,
                      width: 30.w,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : CustomButton(
                      title: "Create Class",
                      callback: () async {
                        print("${homeController.finalcourseName}");
                        print("${homeController.finalsemesterName}");
                        print("${homeController.classNamecontrol.text.trim()}");
                        if (!homeController.validateClassForm()) {
                          return;
                        }

                        await homeController.addnewclass(
                          homeController.finalcourseName ?? "Not found",
                          homeController.finalsemesterName ?? "Not found",
                          homeController.classNamecontrol.text.trim(),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
