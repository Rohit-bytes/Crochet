import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClassesHomepage extends StatelessWidget {
  final String? title;
  final VoidCallback onpress;
  final VoidCallback onlongpress;
  final String? subtitle;
  final Color? color;
  final IconData? icons;
  const new({
    super.key,
    this.title,
    required this.onpress,
    required this.onlongpress,
    this.subtitle,
    this.icons,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onlongpress,
      onTap: () {
        onpress();
      },
      child: Container(
        height: 30.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: Color.lerp(color, Colors.white, 0.7) ?? ColorPalette.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Color.lerp(color, Colors.white, 0.4) ??
                          ColorPalette.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 60,
                    height: 60,
                    child: Icon(
                      size: 40,
                      icons ?? Icons.group,

                      color: color ?? ColorPalette.background,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      (title ?? '').capitalize?.capitalizeFirst ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800,

                        fontSize: 14,
                        color: ColorPalette.textPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ColorPalette.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "$subtitle students",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorPalette.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
