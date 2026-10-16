import 'package:flutter/material.dart';
import 'package:TrustLens/core/color_pallete.dart';

class CustomRadio<T> extends StatelessWidget {
  final T? selectedValue;
  final T value;
  final String title;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  const CustomRadio({
    super.key,
    required this.selectedValue,
    required this.value,
    required this.title,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedValue == value;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: selectedValue,
            activeColor: ColorPalette.primary,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),

          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: isSelected ? ColorPalette.primary : Colors.grey.shade600,
            ),
            const SizedBox(width: 5),
          ],

          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? ColorPalette.primary : Colors.grey.shade700,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
