import '../models/calculator_result.dart';

/// Service responsible for all BMI, BMR, and Calorie calculations.
/// Uses clear Dart functions, mathematical formulas, and conditional logic.
class CalculatorService {
  /// Calculates Body Mass Index (BMI) from weight in kg and height in cm.
  /// Formula: weight (kg) / [height (m)]^2
  static double calculateBMI(double weightKg, double heightCm) {
    if (heightCm <= 0 || weightKg <= 0) {
      throw ArgumentError('Height and weight must be greater than zero.');
    }
    final heightM = heightCm / 100.0;
    return weightKg / (heightM * heightM);
  }

  /// Categorizes adult BMI using standard World Health Organization criteria.
  /// Handles pediatric age (< 18) conditionally.
  static String getBMICategory(double bmi, {bool isUnder18 = false}) {
    if (isUnder18) {
      return 'Pediatric / Under 18';
    }

    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25.0) {
      return 'Normal weight';
    } else if (bmi < 30.0) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  /// Provides general, evidence-aligned health advice based on BMI category and age.
  static String getBMIAdvice(double bmi, {bool isUnder18 = false}) {
    if (isUnder18) {
      return 'Standard adult BMI categories do not apply to children and teenagers under 18. '
          'Growth patterns vary significantly, so pediatricians use growth charts and age-and-sex-specific BMI percentiles. '
          'Please consult a qualified healthcare professional or pediatrician for an individualized assessment.';
    }

    if (bmi < 18.5) {
      return 'Your BMI falls into the underweight category. Focus on balanced, nutrient-dense meals with adequate protein and healthy fats. '
          'We suggest consulting a healthcare professional to discuss your overall wellness and personal nutrition goals.';
    } else if (bmi < 25.0) {
      return 'Your BMI is within the normal healthy weight range. Continue to prioritize a balanced diet, stay hydrated, '
          'and engage in regular physical activity to sustain long-term cardiovascular and metabolic health.';
    } else if (bmi < 30.0) {
      return 'Your BMI falls into the overweight category. Establishing sustainable lifestyle habits, such as regular cardiovascular and resistance exercise '
          'alongside mindful portions, is beneficial. Consider an individual evaluation with a healthcare professional to identify healthy personal targets.';
    } else {
      return 'Your BMI falls into the obesity category. BMI is a screening indicator that does not distinguish muscle from fat mass. '
          'We encourage discussing personalized lifestyle, metabolic health, and nutrition strategies with a qualified healthcare professional.';
    }
  }

  /// Calculates Basal Metabolic Rate (BMR) for adult males using the Mifflin-St Jeor formula.
  /// Formula: (10 × weight in kg) + (6.25 × height in cm) - (5 × age) + 5
  static double calculateBMRMale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must be positive numbers.');
    }
    return (10.0 * weightKg) + (6.25 * heightCm) - (5.0 * age) + 5.0;
  }

  /// Calculates Basal Metabolic Rate (BMR) for adult females using the Mifflin-St Jeor formula.
  /// Formula: (10 × weight in kg) + (6.25 × height in cm) - (5 × age) - 161
  static double calculateBMRFemale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must be positive numbers.');
    }
    return (10.0 * weightKg) + (6.25 * heightCm) - (5.0 * age) - 161.0;
  }

  /// Dispatches BMR calculation based on the user's biological gender.
  static double calculateBMR(
    int age,
    double weightKg,
    double heightCm,
    Gender gender,
  ) {
    switch (gender) {
      case Gender.male:
        return calculateBMRMale(age, weightKg, heightCm);
      case Gender.female:
        return calculateBMRFemale(age, weightKg, heightCm);
    }
  }

  /// Returns the activity multiplier corresponding to the selected activity level.
  static double getActivityMultiplier(ActivityLevel level) {
    return level.multiplier;
  }

  /// Estimates daily maintenance calories (Total Daily Energy Expenditure / TDEE).
  /// Formula: BMR × Activity Multiplier
  static double calculateDailyCalories(
    double bmr,
    double activityMultiplier,
  ) {
    if (bmr <= 0 || activityMultiplier <= 0) {
      throw ArgumentError('BMR and activity multiplier must be positive.');
    }
    return bmr * activityMultiplier;
  }

  /// Calculates goal-adjusted calories (maintain, mild loss of 300 kcal, or mild gain of 300 kcal).
  static double calculateGoalCalories(
    double maintenanceCalories,
    CalorieGoal goal,
  ) {
    final target = maintenanceCalories + goal.calorieAdjustment;
    // Avoid returning unreasonably low calorie targets
    return target > 1000.0 ? target : 1000.0;
  }

  /// Comprehensive calculation function returning a complete [CalculatorResult] model.
  static CalculatorResult calculateAll({
    required int age,
    required Gender gender,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activityLevel,
    required CalorieGoal calorieGoal,
    bool isSpecialPopulation = false,
  }) {
    final isUnder18 = age < 18;
    final bmi = calculateBMI(weightKg, heightCm);
    final bmiCategory = getBMICategory(bmi, isUnder18: isUnder18);
    final bmiAdvice = getBMIAdvice(bmi, isUnder18: isUnder18);

    final bmr = calculateBMR(age, weightKg, heightCm, gender);
    final activityMultiplier = getActivityMultiplier(activityLevel);
    final maintenanceCalories =
        calculateDailyCalories(bmr, activityMultiplier);
    // Avoid adult goal adjustments for minors and special populations.
    final goalCalories = isUnder18 || isSpecialPopulation
        ? null
        : calculateGoalCalories(maintenanceCalories, calorieGoal);

    String safetyMessage = '';
    if (isUnder18) {
      safetyMessage =
          'Notice for users under 18: Caloric and weight targets should not be restricted without guidance. '
          'Energy needs vary heavily with growth spurts and puberty. Please speak with a pediatrician or pediatric dietitian.';
    } else if (isSpecialPopulation) {
      safetyMessage =
          'Notice: Standard adult formulas are not calibrated for pregnancy, lactation, or specific metabolic conditions. '
          'Please consult your physician or registered dietitian for specialized nutritional recommendations.';
    } else {
      safetyMessage =
          'Notice: Calorie targets are illustrative estimates based on the Mifflin-St Jeor equation, not clinical prescriptions. '
          'Listen to your body, appetite, and energy levels.';
    }

    const generalDisclaimer =
        'Disclaimer: This application provides general educational estimates for informational purposes only. '
        'BMI is a screening tool that does not measure body composition or visceral fat. '
        'These calculations should never replace professional medical diagnosis, advice, or treatment.';

    return CalculatorResult(
      bmi: bmi,
      bmiCategory: bmiCategory,
      bmiAdvice: bmiAdvice,
      bmr: bmr,
      maintenanceCalories: maintenanceCalories,
      goalCalories: goalCalories,
      selectedGoal: calorieGoal,
      activityLevel: activityLevel,
      gender: gender,
      age: age,
      weightKg: weightKg,
      heightCm: heightCm,
      isUnder18: isUnder18,
      safetyMessage: safetyMessage,
      generalDisclaimer: generalDisclaimer,
    );
  }
}
