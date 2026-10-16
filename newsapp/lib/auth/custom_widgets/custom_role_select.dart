import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoleSelect extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onPressed;
  final bool isstudent;

  const CustomRoleSelect({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onPressed,
    required this.isstudent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isstudent ? ColorPalette.accent : ColorPalette.primaryLight,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            // color: Colors.amber,
            width: 175.w,
            child: Image.asset(imagePath, height: 180.h),
          ),
          Flexible(
            child: Column(
              children: [
                //two above text

                Container(
                  height: 150,
                  // color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              title,
                              style: TextStyle(
                                wordSpacing: 2,
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        CustomText(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.0.h,
                        vertical: 8.w,
                      ),
                      child: CustomCircleButton(onPressed: onPressed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
