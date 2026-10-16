import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSubjectTile extends StatelessWidget {
  final String subjectName;
  final int credits;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final int index;

  const CustomSubjectTile({
    super.key,
    required this.subjectName,
    required this.credits,
    required this.index,
    this.icon = Icons.menu_book_rounded,
    this.onTap,
    this.onMoreTap,
  });

  // Colors automatically selected according to index
  static const List<Color> subjectColors = [
    Color(0xFF7C4DFF), // Purple
    Color(0xFF2196F3), // Blue
    Color(0xFF00A896), // Teal
    Color(0xFFFF9800), // Orange
    Color(0xFFE91E63), // Pink
    Color(0xFF0097A7), // Cyan
    Color(0xFFF9A825), // Yellow
    Color(0xFFEF5350), // Red
  ];

  Color get tileColor {
    return subjectColors[index % subjectColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final Color color = tileColor;

    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: color, size: 25),
                ),

                SizedBox(width: 12.w),

                // Subject information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subjectName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF202124),
                        ),
                      ),

                      SizedBox(height: 3.h),

                      Text(
                        "$credits Credits",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // More button
                InkWell(
                  onTap: subjectController.isloading == true ? null : onMoreTap,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: subjectController.loadingIndex == true
                        ? Container(
                            height: 10,
                            width: 10,

                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorPalette.error,
                            ),
                          )
                        : Icon(
                            Icons.delete,
                            size: 22,
                            color: ColorPalette.error,
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
