import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomColorButton extends StatelessWidget {
  final String? title;
  final VoidCallback onpress;

  const new({super.key, this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: ColorPalette.white),
          ),
        ),
      ),
    );
  }
}
