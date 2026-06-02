import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;

  // prefix & suffix image paths
  final String? prefixImage;
  final String? suffixImage;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 55,
    this.width = double.infinity,
    this.prefixImage,
    this.suffixImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [ColorPallete.primary, ColorPallete.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Prefix Image
            if (prefixImage != null) ...[
              Image.asset(prefixImage!, height: 24, width: 24),
              const SizedBox(width: 10),
            ],

            // Text
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Suffix Image
            if (suffixImage != null) ...[
              const SizedBox(width: 10),
              Image.asset(suffixImage!, height: 24, width: 24),
            ],
          ],
        ),
      ),
    );
  }
}
