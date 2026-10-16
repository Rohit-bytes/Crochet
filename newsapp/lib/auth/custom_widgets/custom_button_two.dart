import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonTwo extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final Widget? prefixwidget;
  final bool isLoading;

  const CustomButtonTwo({
    super.key,
    required this.title,
    required this.callback,
    this.prefixwidget,
    this.color,
    this.radius,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : callback,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? ColorPalette.white,
          borderRadius: BorderRadius.circular(radius ?? 50),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: textColor ?? ColorPalette.black,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefixwidget != null) prefixwidget!,
                    SizedBox(width: 5.w),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: textColor ?? ColorPalette.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
