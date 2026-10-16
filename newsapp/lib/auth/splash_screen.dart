import 'dart:async';

import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/main.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Floating animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    Timer(const Duration(seconds: 3), () async {
      if (supabase.auth.currentUser == null) {
        Get.offNamed(AppRoutes.chooserole);
      } else {
        final authController = Get.find<AuthController>();
        await authController.getUserDetails();

        Get.offAllNamed(AppRoutes.landingpage);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,

          body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // -10 to +10
              final move = Tween<double>(begin: -10, end: 10).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              );

              return Stack(
                children: [
                  Positioned(
                    top: 200 + move.value,
                    left: -80,
                    child: customsquare(35),
                  ),

                  Positioned(
                    top: 200 - move.value,
                    right: -80,
                    child: customsquare(-35),
                  ),

                  Positioned(
                    top: 600 + move.value,
                    left: -50,
                    child: customsquare(50),
                  ),

                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/splash_screen.png", height: 280.h),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),

                  SizedBox(
                    width: 120.w,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(splashController.currentSlogan.tr),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget customsquare(double angle) {
  return Transform.rotate(
    angle: angle,
    child: Container(
      height: 150.h,
      width: 150.w,
      decoration: BoxDecoration(
        color: ColorPalette.primaryLight.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
