import 'package:flutter/material.dart';

/// Central theme definitions for the BMI & Calorie Calculator app.
/// Implements a crisp, accessible, modern health-tech visual palette.
class AppTheme {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF0284C7); // Vibrant Sky Blue
  static const Color primaryBlueDark = Color(0xFF0369A1);
  static const Color primaryBlueLight = Color(0xFFE0F2FE);

  static const Color secondaryGreen = Color(0xFF10B981); // Emerald Green
  static const Color secondaryGreenDark = Color(0xFF059669);
  static const Color secondaryGreenLight = Color(0xFFD1FAE5);

  // Background and Surfaces
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color cardSurface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF1F5F9); // Slate 100
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400

  // Status & BMI Zone Colors
  static const Color bmiUnderweight = Color(0xFF0284C7); // Sky Blue
  static const Color bmiNormal = Color(0xFF10B981); // Emerald Green
  static const Color bmiOverweight = Color(0xFFF59E0B); // Amber Orange
  static const Color bmiObesity = Color(0xFFEF4444); // Crimson Red
  static const Color bmiPediatric = Color(0xFF8B5CF6); // Purple

  // Spacing Constants
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double cardRadius = 16.0;

  /// Helper to get specific color for a BMI category name.
  static Color getBmiColor(String category) {
    switch (category) {
      case 'Underweight':
        return bmiUnderweight;
      case 'Normal weight':
        return bmiNormal;
      case 'Overweight':
        return bmiOverweight;
      case 'Obesity':
        return bmiObesity;
      case 'Pediatric / Under 18':
      default:
        return bmiPediatric;
    }
  }

  /// App light theme configuration.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        onPrimary: Colors.white,
        primaryContainer: primaryBlueLight,
        onPrimaryContainer: primaryBlueDark,
        secondary: secondaryGreen,
        onSecondary: Colors.white,
        secondaryContainer: secondaryGreenLight,
        onSecondaryContainer: secondaryGreenDark,
        surface: cardSurface,
        onSurface: textPrimary,
        error: bmiObesity,
        onError: Colors.white,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: cardSurface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardTheme(
        color: cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: borderLight, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textSecondary,
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: borderLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: textMuted,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: bmiObesity, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: bmiObesity, width: 2),
        ),
      ),
    );
  }
}
