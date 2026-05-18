import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:crochet/view/homescreens/homepage.dart';
import 'package:crochet/view/homescreens/homescreencomponents/splashname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 5,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    // Wait 3 sec first
    Future.delayed(const Duration(seconds: 3), () async {
      // Start grow animation
      await controller.forward();

      // Navigate after animation
      Get.off(
        () => const Homepage(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primary,
      body: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.gif", height: 100, width: 100),
              const SizedBox(height: 20),
              const AnimatedLogoText(),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:crochet/view/customtheme/color_pallete.dart';
// import 'package:crochet/view/homescreens/homepage.dart';
// import 'package:crochet/view/homescreens/homescreencomponents/splashname.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> topAnimation;
//   late Animation<double> leftAnimation;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     topAnimation = Tween<double>(
//       begin: 0,
//       end: -300,
//     ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

//     leftAnimation = Tween<double>(
//       begin: 0,
//       end: -140,
//     ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

//     scaleAnimation = Tween<double>(
//       begin: 1,
//       end: 0.4,
//     ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

//     // wait 3 sec
//     Future.delayed(const Duration(seconds: 3), () async {
//       // animate cat to top-left
//       await controller.forward();

//       // open homepage
//       Get.off(
//         () => const Homepage(),
//         transition: Transition.fadeIn,
//         duration: const Duration(milliseconds: 500),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       backgroundColor: ColorPallete.primary,
//       body: AnimatedBuilder(
//         animation: controller,
//         builder: (context, child) {
//           return Stack(
//             children: [
//               Center(
//                 child: Transform.translate(
//                   offset: Offset(leftAnimation.value, topAnimation.value),
//                   child: Transform.scale(
//                     scale: scaleAnimation.value,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.asset("assets/logo.gif", height: 100, width: 100),
//                         const SizedBox(height: 20),
//                         const AnimatedLogoText(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
