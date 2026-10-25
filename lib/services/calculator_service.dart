import '../models/calculator_result.dart';

/// Service responsible for all mathematical calculations, physiological estimations,
/// classification boundaries, and non-diagnostic guidance generation.
class CalculatorService {
  /// Calculates Body Mass Index (BMI) using the standard metric formula:
  /// BMI = weight (kg) / [height (m)]^2
  /// Throws [ArgumentError] if height or weight are non-positive.
  static double calculateBMI(double weightKg, double heightCm) {
    if (heightCm <= 0) {
      throw ArgumentError('Height must be greater than zero.');
    }
    if (weightKg <= 0) {
      throw ArgumentError('Weight must be greater than zero.');
    }
    final heightM = heightCm / 100.0;
    final bmi = weightKg / (heightM * heightM);
    if (!bmi.isFinite) {
      throw ArgumentError('Calculated BMI is not a finite number.');
    }
    return bmi;
  }

  /// Classifies adult BMI into standard World Health Organization categories.
  /// Note: Should only be applied to adults (age >= 18).
  static String getBMICategory(double bmi) {
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

  /// Provides non-diagnostic lifestyle guidance based on BMI classification.
  /// If [isPediatric] is true, returns age-appropriate clinical guidance instead.
  static String getBMIAdvice(double bmi, {bool isPediatric = false}) {
    if (isPediatric) {
      return 'For children and adolescents under 18, standard adult BMI categories do not apply. '
          'Body composition in youth varies significantly with growth stages, age, and sex. '
          'Please consult a pediatrician or qualified healthcare professional to evaluate growth using pediatric percentiles.';
    }

    if (bmi < 18.5) {
      return 'Your BMI falls below the standard adult normal range. Consider focusing on nutrient-dense foods, '
          'adequate energy intake, and consulting a healthcare provider or registered dietitian to evaluate overall nutritional status.';
    } else if (bmi < 25.0) {
      return 'Your BMI is within the healthy adult range. Continue maintaining balanced dietary patterns, regular physical '
          'activity (at least 150 minutes of moderate activity weekly), restorative sleep, and routine wellness checkups.';
    } else if (bmi < 30.0) {
      return 'Your BMI is above the standard healthy range. Prioritize sustainable lifestyle habits including daily moderate activity, '
          'whole foods, hydration, and mindful portion sizes. Consider an individualized assessment with a healthcare professional.';
    } else {
      return 'Your BMI indicates obesity classification. Discussing your personal health profile, metabolic biomarkers, and sustainable '
          'wellness strategies with a doctor or qualified nutritionist is strongly recommended to support long-term well-being.';
    }
  }

  /// Calculates Basal Metabolic Rate (BMR) for males using the Mifflin-St Jeor equation:
  /// BMR = (10 * weight in kg) + (6.25 * height in cm) - (5 * age in years) + 5
  static double calculateBMRMale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must all be positive values.');
    }
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
  }

  /// Calculates Basal Metabolic Rate (BMR) for females using the Mifflin-St Jeor equation:
  /// BMR = (10 * weight in kg) + (6.25 * height in cm) - (5 * age in years) - 161
  static double calculateBMRFemale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must all be positive values.');
    }
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
  }

  /// Returns the corresponding physical activity multiplier.
  static double getActivityMultiplier(ActivityLevel level) {
    return level.multiplier;
  }

  /// Computes estimated total daily maintenance calorie expenditure (TDEE).
  /// Formula: TDEE = BMR * Activity Multiplier
  static double calculateDailyCalories(double bmr, double activityMultiplier) {
    if (bmr <= 0 || activityMultiplier <= 0) {
      throw ArgumentError('BMR and activity multiplier must be positive values.');
    }
    final calories = bmr * activityMultiplier;
    if (!calories.isFinite) {
      throw ArgumentError('Calculated daily calories are not finite.');
    }
    return calories;
  }

  /// Computes the optional illustrative goal calorie estimate.
  /// Adjusts maintenance calories by the goal offset (-300 for loss, +300 for gain, 0 for maintain).
  /// Returns null if user is under 18 or if the target is unfeasibly low (< 500 kcal/day).
  static double? calculateGoalCalories({
    required double maintenanceCalories,
    required CalorieGoal goal,
    required bool isPediatric,
  }) {
    if (isPediatric) {
      return null;
    }

    final target = maintenanceCalories + goal.calorieOffset;
    if (target < 500 || !target.isFinite) {
      return null;
    }
    return target;
  }

  /// Orchestrates full calculation workflow and returns an immutable [CalculatorResult].
  static CalculatorResult calculateAll({
    required int age,
    required BiologicalSex sex,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activityLevel,
    required CalorieGoal calorieGoal,
  }) {
    final isPediatric = age < 18;

    // 1. BMI Calculation
    final bmi = calculateBMI(weightKg, heightCm);

    // 2. Category & Advice
    final bmiCategory = isPediatric ? 'Pediatric (<18 yrs)' : getBMICategory(bmi);
    final bmiAdvice = getBMIAdvice(bmi, isPediatric: isPediatric);

    // 3. BMR Calculation (Mifflin-St Jeor)
    final double bmr;
    if (sex == BiologicalSex.male) {
      bmr = calculateBMRMale(age, weightKg, heightCm);
    } else {
      bmr = calculateBMRFemale(age, weightKg, heightCm);
    }

    // 4. Daily Maintenance Calories
    final multiplier = getActivityMultiplier(activityLevel);
    final maintenance = calculateDailyCalories(bmr, multiplier);

    // 5. Calorie Goal Estimation
    final goalCalories = calculateGoalCalories(
      maintenanceCalories: maintenance,
      goal: calorieGoal,
      isPediatric: isPediatric,
    );

    // 6. Safety Notice
    String? safetyNotice;
    if (isPediatric) {
      safetyNotice = 'Note: Age is under 18 years. Caloric and BMI assessments are illustrative only. '
          'Pediatric nutrition and growth tracking require professional medical consultation.';
    }

    return CalculatorResult(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
      calorieGoal: calorieGoal,
      bmi: bmi,
      bmiCategory: bmiCategory,
      bmiAdvice: bmiAdvice,
      bmr: bmr,
      maintenanceCalories: maintenance,
      goalCalories: goalCalories,
      isPediatric: isPediatric,
      safetyNotice: safetyNotice,
    );
  }
}
