import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/classes_homepage.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:TrustLens/view/custom_homepage_widgets.dart/custom_dialog.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewAllClasses extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: CustomAppBar(title: "All Classes"),
          backgroundColor: ColorPalette.background,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                homeController.classes.length == 0
                    ? SizedBox(
                        height: 180.h,
                        // width: 250.w,
                        child: Image.asset("assets/addClass.png"),
                      )
                    : Expanded(
                        child: GridView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 20.h),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 1.05,
                              ),
                          itemCount: homeController.classes.length,

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
                                          homeController.classes[index]["id"],
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
              ],
            ),
          ),
        );
      },
    );
  }
}
