import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

class ClassWidget extends StatelessWidget {
  final String courseName;
  const ClassWidget({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      constraints: BoxConstraints(minHeight: 140.h),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.surface,
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: ColorPalette.background,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.school_sharp,
                      color: Colors.blue,
                      size: 60,
                    ),
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  courseName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: ColorPalette.textPrimary,
                  ),
                ),

                SizedBox(height: 5.h),

                Row(
                  children: [
                    const Icon(Icons.people_alt_outlined),
                    SizedBox(width: 2.w),
                    Text(
                      "Students",
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorPalette.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: ColorPalette.background,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
