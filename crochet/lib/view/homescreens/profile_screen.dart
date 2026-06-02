import 'package:crochet/view/apputils/custom_elevated_button.dart';
import 'package:crochet/view/auth_screen/loginscreen.dart';
import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.background,
      body: Center(
        child: CustomElevatedButton(
          width: 200.w,
          prefixImage: "assets/logo.gif",
          height: 40.h,

          text: "Login Screen",
          onPressed: () {
            Get.to(() => const Loginscreen());
          },
        ),
      ),
    );
  }
}
