import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const new({super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPalette.black,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCircleButton(),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: ColorPalette.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                height: 40.h,
                child: CustomCircleButton(onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
