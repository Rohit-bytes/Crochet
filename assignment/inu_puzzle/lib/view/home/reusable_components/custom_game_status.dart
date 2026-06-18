import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GamePopup {
  static void show({
    required String title,
    required String subtitle,
    required String animation,
    Color color = Colors.blue,
  }) {
    showGeneralDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierLabel: "Popup",
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(animation, height: 180),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(subtitle, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.canPop(Get.context!)) {
        Get.back();
      }
    });
    // Get.dialog(
    //   Material(
    //     color: Colors.black.withOpacity(0.8),
    //     child: Center(
    //       child: TweenAnimationBuilder(
    //         duration: const Duration(milliseconds: 500),
    //         tween: Tween(begin: 0.5, end: 1.0),
    //         curve: Curves.elasticOut,
    //         builder: (context, value, child) {
    //           return Transform.scale(scale: value, child: child);
    //         },
    //         child: Container(
    //           width: 300,
    //           margin: const EdgeInsets.symmetric(horizontal: 10),
    //           padding: const EdgeInsets.all(24),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(30),
    //           ),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Lottie.asset(animation, height: 180),
    //               const SizedBox(height: 20),
    //               Text(
    //                 title,
    //                 style: TextStyle(
    //                   fontSize: 28,
    //                   fontWeight: FontWeight.bold,
    //                   color: color,
    //                 ),
    //               ),
    //               const SizedBox(height: 10),
    //               Text(
    //                 subtitle,
    //                 textAlign: TextAlign.center,
    //                 style: const TextStyle(fontSize: 16),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   barrierDismissible: false,
    // );

    // Future.delayed(const Duration(seconds: 3), () {
    //   if (Get.isDialogOpen ?? false) {
    //     Get.back();
    //   }
    // });
  }

  static void win() {
    show(
      title: "🎉 YOU WIN!",
      subtitle: "Amazing! You nailed it.",
      animation: "assets/trophy.json",
      color: Colors.green,
    );
  }

  static void lose() {
    show(
      title: "😢 TRY AGAIN",
      subtitle: "You were so close!",
      animation: "assets/fail.json",
      color: Colors.red,
    );
  }

  static void timeUp() {
    show(
      title: "⏰ TIME'S UP",
      subtitle: "Better luck next round.",
      animation: "assets/clock.json",
      color: Colors.orange,
    );
  }
}
