import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/auth/custom_widgets/custom_text.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/classes_homepage.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_dialog.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_title_anchor.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_trackers.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/upcoming_class.dart';
import 'package:TrustLens/view/widgets/newsAppHeader.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Homepage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              backgroundColor: ColorPalette.background,
              body: RefreshIndicator(
                onRefresh: () async {
                  return await homeController.getClasses();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            "Hello,${authController.userDetails?.name ?? "User"} 👋",
                          ),
                        ],
                      ),
                      Row(children: [Text("Let's Make Today Productive!")]),
                      NewsAppHeader(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
