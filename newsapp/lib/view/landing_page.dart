import 'package:TrustLens/auth/custom_widgets/custom_circle_button.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/homepage.dart';
import 'package:TrustLens/view/profile_screen.dart';
import 'package:TrustLens/main.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              backgroundColor: ColorPalette.background,
              appBar: CustomAppBar(
                leadingwidget: homeController.currentIndex == 1
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCircleButton(
                          onPressed: () {
                            homeController.changeIndex(0);
                          },
                          icon: Icons.keyboard_arrow_left,
                        ),
                      )
                    : Icon(Icons.menu),
                title: homeController.currentIndex == 1
                    ? "Profile"
                    : homeController.getGreeting(),

                showBackButton: false,
                actions: [
                  homeController.currentIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8,
                          ),
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            child: CustomCircleButton(
                              icon: Icons.edit_outlined,
                              iconsize: 16,
                              onPressed: () {
                                // supabase.auth.signOut();
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),

              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PageView(
                  controller: homeController.pageController,
                  onPageChanged: (value) {
                    homeController.changeIndex(value);
                  },
                  children: [Homepage(), ProfileScreen()],
                ),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: homeController.currentIndex,
                  onTap: (value) {
                    homeController.changeIndex(value);
                  },
                  // type: BottomNavigationBarType.shifting,
                  showUnselectedLabels: true,

                  selectedItemColor: ColorPalette.primary,
                  unselectedItemColor: ColorPalette.black,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile".tr,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
