import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuEntry<String>> items;
  final String? value;
  final String hintText;
  final String? label;
  final IconData? leadingIcon;
  final ValueChanged<String?>? onSelected;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.items,
    this.value,
    this.hintText = 'Select',
    this.label,
    this.errorText,
    this.leadingIcon,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF17213A),
            ),
          ),
          const SizedBox(height: 10),
        ],

        DropdownMenu<String>(
          width: double.infinity,

          initialSelection: null,

          // Error text
          errorText: errorText,

          hintText: hintText.capitalizeFirst,

          leadingIcon: leadingIcon == null
              ? null
              : Icon(leadingIcon, color: const Color(0xFF40527A), size: 28),

          trailingIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF40527A),
            size: 28,
          ),

          textStyle: const TextStyle(
            color: Color(0xFF40527A),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),

          menuStyle: MenuStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            elevation: const WidgetStatePropertyAll(4),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
          showTrailingIcon: true,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,

            hintStyle: const TextStyle(
              color: Color(0xFF8793AC),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

            // Normal border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFE1E7F0),
                width: 1.2,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFE1E7F0),
                width: 1.2,
              ),
            ),

            // Focused
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF40527A),
                width: 1.5,
              ),
            ),

            // 🔴 Error border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 1.2),
            ),

            // 🔴 Focused error border
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),

            // Error text style
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          dropdownMenuEntries: items,

          onSelected: onSelected,
        ),
      ],
    );
  }
}
