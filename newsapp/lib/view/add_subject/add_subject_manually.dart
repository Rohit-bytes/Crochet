import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text_field.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:TrustLens/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterSubjectManually extends StatefulWidget {
  const new({super.key});

  @override
  State<EnterSubjectManually> createState() => _EnterSubjectManuallyState();
}

class _EnterSubjectManuallyState extends State<EnterSubjectManually> {
  TextEditingController subjectName = TextEditingController();
  TextEditingController subjectCode = TextEditingController();
  TextEditingController credits = TextEditingController();
  String? errorsubName, errorSubjectCode, errorCredits;
  final Map<String, dynamic> newClass = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String className = newClass['class_name'];
    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(title: ""),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CustomText("Add Subject Manually"),
                  Text("Add a Subject to ${className}"),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    errorText: errorsubName,
                    controller: subjectName,
                    hint: "Subject Name",
                    prefixIcon: Icons.subject,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    errorText: errorSubjectCode,
                    controller: subjectCode,
                    hint: "Subject Code",
                    prefixIcon: Icons.code,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    errorText: errorCredits,
                    controller: credits,
                    hint: "Credits",
                    prefixIcon: Icons.new_releases_outlined,
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonTwo(
                isLoading: subjectController.isloading,

                textColor: ColorPalette.white,
                color: ColorPalette.primary,
                title: "Add Subject",

                callback: () {
                  bool isValid = true;

                  // Subject name validation
                  if (subjectName.text.trim().isEmpty) {
                    setState(() {
                      errorsubName = "Subject name is required";
                    });
                    isValid = false;
                  }

                  // Subject code validation
                  if (subjectCode.text.trim().isEmpty) {
                    setState(() {
                      errorSubjectCode = "Subject code is required";
                    });
                    isValid = false;
                  }

                  // Credits validation
                  final int? creditValue = int.tryParse(credits.text.trim());

                  if (credits.text.trim().isEmpty) {
                    setState(() {
                      errorCredits = "Credits are required";
                    });
                    isValid = false;
                  } else if (creditValue == null) {
                    setState(() {
                      errorCredits = "Enter a valid number";
                    });
                    isValid = false;
                  }

                  if (!isValid) {
                    return;
                  }
                  subjectController.addNewSubject(
                    subjectName: subjectName.text.trim(),
                    subjectCode: subjectCode.text.trim(),
                    credits: int.parse(credits.text.trim()),
                    classId: newClass["id"],
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
