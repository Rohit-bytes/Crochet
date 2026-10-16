import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/add_class/attendance_widgets.dart/today_attendance.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AttendanceTab extends StatelessWidget {
  final Map<String, dynamic> newClass;
  const new({super.key, required this.newClass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TodayAttendance(),
          SizedBox(height: 10.h),
          CustomButtonTwo(
            color: ColorPalette.primary,
            textColor: ColorPalette.white,
            radius: 10,
            prefixwidget: Icon(Icons.qr_code, color: ColorPalette.white),
            title: "Start Attendance",
            callback: () {
              Get.toNamed(AppRoutes.StartAttendanceScreen, arguments: newClass);
            },
          ),
        ],
      ),
    );
  }
}
