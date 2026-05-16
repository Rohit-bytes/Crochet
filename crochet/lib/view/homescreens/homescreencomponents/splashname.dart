import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:flutter/material.dart';

class AnimatedLogoText extends StatefulWidget {
  const AnimatedLogoText({super.key});

  @override
  State<AnimatedLogoText> createState() => _AnimatedLogoTextState();
}

class _AnimatedLogoTextState extends State<AnimatedLogoText> {
  bool isCro = true;

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) {
        return false;
      }

      setState(() {
        isCro = !isCro;
      });

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),

          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },

          child: Text(
            isCro ? "CRO" : "CAT",
            key: ValueKey(isCro),

            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ColorPallete.primary,
            ),
          ),
        ),

        const Text(
          "CHET",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorPallete.primary,
          ),
        ),
      ],
    );
  }
}
