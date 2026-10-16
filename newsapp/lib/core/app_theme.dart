import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Colors
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.primary,
      primary: ColorPalette.primary,
      secondary: ColorPalette.accent,
      surface: ColorPalette.surface,
      error: ColorPalette.error,
    ),

    scaffoldBackgroundColor: ColorPalette.surface,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.surface,
      foregroundColor: ColorPalette.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    // Text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: ColorPalette.textPrimary),
      bodyMedium: TextStyle(color: ColorPalette.textSecondary),
      bodySmall: TextStyle(color: ColorPalette.textSecondary),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorPalette.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),

      hintStyle: const TextStyle(color: ColorPalette.textSecondary),

      prefixIconColor: ColorPalette.textSecondary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ColorPalette.primary, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ColorPalette.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ColorPalette.error, width: 1.5),
      ),
    ),

    // Elevated Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.primary,
        foregroundColor: ColorPalette.white,

        minimumSize: const Size(double.infinity, 54),

        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Outlined Buttons
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorPalette.primary,

        minimumSize: const Size(double.infinity, 54),

        side: const BorderSide(color: ColorPalette.primary),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: ColorPalette.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE2E8F0),
      thickness: 1,
    ),
  );
}
