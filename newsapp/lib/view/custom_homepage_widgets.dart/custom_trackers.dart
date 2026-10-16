import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTrackers extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? subtitle;
  const new({super.key, this.color, this.subtitle, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 110.w,
      decoration: BoxDecoration(
        color: color ?? ColorPalette.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title ?? "4",
              style: TextStyle(
                color: ColorPalette.white,
                fontSize: 12.w,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              subtitle ?? "Classes",
              style: TextStyle(
                color: ColorPalette.white,
                fontSize: 12.w,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
