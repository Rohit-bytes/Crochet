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
                            "Hello,\n${authController.userDetails?.name ?? "User"} 👋",
                          ),
                        ],
                      ),
                      Row(children: [Text("Let's Make Today Productive!")]),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTrackers(
                            color: ColorPalette.primaryLight,
                            title: "0",
                            subtitle: "Classes".tr,
                          ),
                          CustomTrackers(
                            color: ColorPalette.Green,
                            title: "0",
                            subtitle: 'Students'.tr,
                          ),
                          CustomTrackers(
                            color: ColorPalette.creme,
                            title: "100%",
                            subtitle: "Avg. Attendance",
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomTitleAnchor(
                        title: "Classes".tr,
                        widget: Row(
                          children: [
                            CustomColorButton(
                              title: "+ Add Class",
                              onpress: () {
                                Get.toNamed(AppRoutes.addclass);
                              },
                            ),
                            SizedBox(width: 5.w),
                            CustomColorButton(
                              title: "Show All",
                              onpress: () {
                                Get.toNamed(AppRoutes.viewallclasses);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      homeController.classes.length == 0
                          ? SizedBox(
                              height: 180.h,
                              // width: 250.w,
                              child: Image.asset("assets/addClass.png"),
                            )
                          : Container(
                              // height: 400.h,
                              // constraints: BoxConstraints(minHeight: 300.h),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 20.h),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12.w,
                                      mainAxisSpacing: 12.h,
                                      childAspectRatio: 1.05,
                                    ),
                                itemCount: homeController.classes.length > 4
                                    ? 4
                                    : homeController.classes.length,
                                itemBuilder: (context, index) {
                                  return ClassesHomepage(
                                    onlongpress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialog(
                                            message: "Are you sure you want to delete this class?",
                                            firstButtonText: "Cancel",
                                            secondButtonText: "Yes",
                                            onFirstPressed: () {
                                              Get.back();
                                            },
                                            onSecondPressed: () {
                                              homeController.deleteClass(
                                                homeController
                                                    .classes[index]["id"],
                                              );
                                              Get.back();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icons: homeController.getCourseIcon(
                                      homeController.classes[index]["course"],
                                    ),

                                    color: homeController.getCourseColor(
                                      homeController.classes[index]["course"],
                                    ),
                                    title:
                                        "${homeController.classes[index]["class_name"]}",
                                    subtitle: "120",

                                    onpress: () {
                                      print(
                                        "${homeController.classes[index]["class_name"]}",
                                      );
                                      print(
                                        "${homeController.classes[index]["semester"]}",
                                      );
                                      Get.toNamed(
                                        AppRoutes.uploadexcelsheet,
                                        arguments: {
                                          'id':
                                              '${homeController.classes[index]["id"]}',
                                          'semester':
                                              "${homeController.classes[index]["semester"]}",
                                          'class_name':
                                              "${homeController.classes[index]["class_name"]}",
                                        },
                                      );
                                      print(index);
                                    },
                                  );
                                },
                              ),
                            ),

                      // SizedBox(height: 10.h),
                      CustomTitleAnchor(
                        title: "Today's Schedule",
                        widget: Row(
                          children: [
                            TextButton(
                              child: Text("View All"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      UpcomingClassesWidget(),
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
