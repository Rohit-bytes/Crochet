import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceStatus extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;

  const AttendanceStatus({
    super.key,
    required this.text,
    this.color,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = color ?? const Color(0xFF008A5A);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFE8FAF3),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: borderColor ?? const Color(0xFFC4F1DF),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.circle, size: 3, color: Colors.white),
          ),

          SizedBox(width: 10.w),

          Text(
            text,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
