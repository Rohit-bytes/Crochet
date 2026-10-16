import 'dart:convert';

import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:TrustLens/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  // late String attendanceid;
  // late SubjectController subjectController;

  @override
  void initState() {
    super.initState();

    final subjectController = Get.find<SubjectController>();
    final attendanceid = Get.arguments.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subjectController.fetchattendancedata(attendanceid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (subController) {
        final dateString = subController.startAttendance['date']?.toString();

        return Scaffold(
          backgroundColor: ColorPalette.background,

          appBar: CustomAppBar(
            onBack: () {
              Get.back();
            },
            fontsize: 16,
            title: "Start Attendance",
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.Green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: SizedBox(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Active",
                        style: TextStyle(
                          color: ColorPalette.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: subController.startAttendance.isEmpty
              ? Center(
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      CustomText(subController.startAttendance["subject_name"]),
                      Text(
                        "${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(subController.startAttendance["date"])).toUpperCase()}",
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: QrImageView(
                                data: jsonEncode({
                                  'id': subController.startAttendance['id'],
                                  'subject_id': subController
                                      .startAttendance['subject_id'],
                                  'subject_name': subController
                                      .startAttendance["subject_name"],
                                  'class_id':
                                      subController.startAttendance['classid'],
                                }),
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Scan to mark attendance",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: ColorPalette.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: ColorPalette.primary,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
