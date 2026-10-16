import 'package:TrustLens/auth/custom_widgets/custom_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitleAnchor extends StatelessWidget {
  final String? title;
  final Widget? widget;
  const new({super.key, this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [CustomText(title ?? ""), if (widget != null) ?widget],
      ),
    );
  }
}
