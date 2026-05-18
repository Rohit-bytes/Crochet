import 'dart:ui';

import 'package:crochet/view/apputils/customappbar.dart';
import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:crochet/view/homescreens/favorite_screen.dart';
import 'package:crochet/view/homescreens/homescreencomponents/customimageview.dart';
import 'package:crochet/viewmodel/homecontrollers/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return GetBuilder<HomepageController>(
      builder: (homepagecontroller) {
        return Scaffold(
          backgroundColor: ColorPallete.background,
          appBar: CustomAppBar(
            height: isLandscape ? 100.h : 35.h,
            title: "Crochet",
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              homepagecontroller.isLoading == true
                  ? Expanded(
                      child: Center(
                        child: Image.asset(
                          "assets/logo.gif",
                          height: 40.h,
                          width: 30.w,
                        ),
                      ),
                    )
                  : Expanded(
                      child: PageView(
                        controller: homepagecontroller.pagecontroller,
                        onPageChanged: (index) {
                          homepagecontroller.changeindex(index);
                        },
                        children: [
                          RefreshIndicator(
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            color: ColorPallete.primary,
                            backgroundColor: Colors.white,
                            onRefresh: () async {
                              await homepagecontroller.getCats();
                            },

                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),

                              itemCount: homepagecontroller.cats.length,

                              itemBuilder: (context, index) {
                                final item = homepagecontroller.cats[index];

                                return Customimageview(
                                  key: ValueKey(item['id']),
                                  imageUrl: item['url'],
                                  onDownload: () {
                                    homepagecontroller.downloadImage(
                                      context,
                                      item['url'],
                                    );
                                    print("Downloading ${item['url']}");
                                  },
                                );
                              },
                            ),
                          ),

                          FavoriteScreen(),
                        ],
                      ),
                    ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(16.h),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

                child: Container(
                  height: 55.h,

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.12),

                    borderRadius: BorderRadius.circular(50.r),

                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50.r),
                        onTap: () {
                          homepagecontroller.changeindex(0);
                        },

                        child: Padding(
                          padding: EdgeInsets.all(10.w),

                          child: Image.asset("assets/logo.gif", height: 28.h),
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(50.r),
                        onTap: () {
                          homepagecontroller.changeindex(1);
                        },

                        child: Padding(
                          padding: EdgeInsets.all(10.w),

                          child: Image.asset(
                            "assets/favorite.gif",
                            height: 28.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
