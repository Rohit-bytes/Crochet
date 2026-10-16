import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:TrustLens/core/color_pallete.dart';

class UpcomingClassesWidget extends StatelessWidget {
  const UpcomingClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================
        // CLASS CARD
        // =========================
        _classCard(
          subject: "DBMS",
          course: "MCA • Semester 1",
          time: "10:00 AM",
          room: "Room 201",
          icon: Icons.storage_rounded,
          iconColor: const Color(0xff7C4DFF),
          iconBackground: const Color(0xffEEE7FF),
          isNext: true,
        ),

        SizedBox(height: 10.h),

        _classCard(
          subject: "Java",
          course: "BCA • Semester 5",
          time: "12:00 PM",
          room: "Room 105",
          icon: Icons.code_rounded,
          iconColor: const Color(0xffFF9800),
          iconBackground: const Color(0xfffff0d9),
          isNext: false,
        ),

        SizedBox(height: 10.h),

        _classCard(
          subject: "Computer Networks",
          course: "BCA • Semester 5",
          time: "02:00 PM",
          room: "Lab 2",
          icon: Icons.computer_rounded,
          iconColor: ColorPalette.primary,
          iconBackground: const Color(0xffe3efff),
          isNext: false,
        ),
      ],
    );
  }

  // ============================================================
  // CLASS CARD
  // ============================================================

  Widget _classCard({
    required String subject,
    required String course,
    required String time,
    required String room,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required bool isNext,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(13.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // =========================
          // SUBJECT ICON
          // =========================

          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),

          SizedBox(width: 12.w),

          // =========================
          // DETAILS
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorPalette.textPrimary,
                  ),
                ),

                SizedBox(height: 3.h),

                Text(
                  course,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: ColorPalette.textSecondary,
                  ),
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.sp,
                      color: ColorPalette.textSecondary,
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.textPrimary,
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: ColorPalette.textSecondary,
                    ),

                    SizedBox(width: 3.w),

                    Text(
                      room,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // =========================
          // ACTION
          // =========================
          if (isNext)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorPalette.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.primary,
                ),
              ),
            )
          else
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: ColorPalette.textSecondary,
            ),
        ],
      ),
    );
  }
}
