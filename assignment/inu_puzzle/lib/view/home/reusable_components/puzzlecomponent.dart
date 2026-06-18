import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inu_puzzle/viewmodel/puzzlecontroller.dart';

class Puzzlecomponent extends StatelessWidget {
  final double? height;
  final double? width;
  const Puzzlecomponent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Puzzlecontroller>(
      builder: (puzzlecontroller) {
        return Container(
          height: height ?? 80,
          width: width ?? 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              style: BorderStyle.solid,
              width: 3,
            ),

            color: Color.fromRGBO(9, 57, 109, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(puzzlecontroller.puzzleUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
