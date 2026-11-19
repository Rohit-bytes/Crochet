import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: loading
            ? const SizedBox(
                height: 22, width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white,
                ),
              )
            : Text(title, style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
