import 'package:crochet/view/customtheme/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customimageview extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDownload;
  const Customimageview({
    super.key,
    required this.imageUrl,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: isLandscape ? 800.h : 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(172, 0, 0, 0).withOpacity(0.12),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.error, color: Colors.red, size: 50),
                  );
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      onDownload();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorPallete.background,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                        Icons.catching_pokemon_outlined,
                        color: ColorPallete.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
