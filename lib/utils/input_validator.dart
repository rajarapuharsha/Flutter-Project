/// Reusable validation layer providing field-specific error messages and
/// safety bound constraints for user input.
class InputValidator {
  // Input boundary definitions
  static const int minAge = 2;
  static const int maxAge = 120;

  static const double minHeightCm = 50.0;
  static const double maxHeightCm = 260.0;

  static const double minWeightKg = 10.0;
  static const double maxWeightKg = 400.0;

  /// Validates age input string.
  /// Requires a positive non-empty whole integer within [minAge] and [maxAge].
  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your age.';
    }

    final trimmed = value.trim();
    final parsed = int.tryParse(trimmed);
    if (parsed == null) {
      return 'Please enter a valid whole number for age.';
    }

    if (parsed < minAge || parsed > maxAge) {
      return 'Age must be between $minAge and $maxAge years.';
    }

    return null;
  }

  /// Validates height in centimeters.
  /// Requires a positive numeric value (decimals allowed) within [minHeightCm] and [maxHeightCm].
  static String? validateHeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your height.';
    }

    final trimmed = value.trim();
    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return 'Please enter a valid number for height.';
    }

    if (parsed <= 0) {
      return 'Height must be greater than zero.';
    }

    if (parsed < minHeightCm || parsed > maxHeightCm) {
      return 'Height must be between $minHeightCm and $maxHeightCm cm.';
    }

    return null;
  }

  /// Validates weight in kilograms.
  /// Requires a positive numeric value (decimals allowed) within [minWeightKg] and [maxWeightKg].
  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your weight.';
    }

    final trimmed = value.trim();
    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return 'Please enter a valid number for weight.';
    }

    if (parsed <= 0) {
      return 'Weight must be greater than zero.';
    }

    if (parsed < minWeightKg || parsed > maxWeightKg) {
      return 'Weight must be between $minWeightKg and $maxWeightKg kg.';
    }

    return null;
  }
}
