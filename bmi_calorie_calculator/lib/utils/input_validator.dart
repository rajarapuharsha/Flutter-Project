import '../models/calculator_result.dart';

/// Comprehensive utility class for validating user input fields across the app.
class InputValidator {
  /// Validates the age string input.
  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your age.';
    }

    final trimmed = value.trim();
    final parsed = int.tryParse(trimmed);

    if (parsed == null) {
      return 'Please enter a valid whole number for age.';
    }

    if (parsed <= 0) {
      return 'Age must be greater than 0.';
    }

    if (parsed < 1 || parsed > 120) {
      return 'Age must be between 1 and 120 years.';
    }

    return null;
  }

  /// Validates the height string input in centimeters.
  static String? validateHeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your height.';
    }

    final trimmed = value.trim();
    final parsed = double.tryParse(trimmed);

    if (parsed == null) {
      return 'Please enter a valid numeric height.';
    }

    if (parsed <= 0) {
      return 'Height must be greater than zero.';
    }

    if (parsed < 50.0 || parsed > 250.0) {
      return 'Height must be between 50 cm and 250 cm.';
    }

    return null;
  }

  /// Validates the weight string input in kilograms.
  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your weight.';
    }

    final trimmed = value.trim();
    final parsed = double.tryParse(trimmed);

    if (parsed == null) {
      return 'Please enter a valid numeric weight.';
    }

    if (parsed <= 0) {
      return 'Weight must be greater than zero.';
    }

    if (parsed < 10.0 || parsed > 300.0) {
      return 'Weight must be between 10 kg and 300 kg.';
    }

    return null;
  }

  /// Validates that a gender option has been selected.
  static String? validateGender(Gender? gender) {
    if (gender == null) {
      return 'Please select your biological gender.';
    }
    return null;
  }

  /// Validates that an activity level option has been selected.
  static String? validateActivityLevel(ActivityLevel? level) {
    if (level == null) {
      return 'Please select your activity level.';
    }
    return null;
  }
}
