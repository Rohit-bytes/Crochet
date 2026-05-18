import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPallete.background,
      body: Center(child: Text("Favorite Screen")),
    );
  }
}
