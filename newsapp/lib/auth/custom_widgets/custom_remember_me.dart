import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomRememberMe extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 20.h,
              width: 20.w,
              child: Center(
                child: Icon(Icons.check, size: 15.w, color: ColorPalette.white),
              ),
            ),
            SizedBox(width: 5.w),
            Text("Remember me".tr),
          ],
        ),
        TextButton(
          child: Text(
            "Forgot Password?",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
