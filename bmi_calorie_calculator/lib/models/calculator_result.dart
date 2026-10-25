/// Enum representing biological gender for the Mifflin-St Jeor formula.
enum Gender {
  male,
  female,
}

/// Enum representing daily physical activity levels and their descriptive text.
enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extraActive,
}

/// Extension on ActivityLevel to provide user-facing titles and descriptions.
extension ActivityLevelExtension on ActivityLevel {
  String get title {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Sedentary';
      case ActivityLevel.lightlyActive:
        return 'Lightly active';
      case ActivityLevel.moderatelyActive:
        return 'Moderately active';
      case ActivityLevel.veryActive:
        return 'Very active';
      case ActivityLevel.extraActive:
        return 'Extra active';
    }
  }

  String get description {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Little or no exercise';
      case ActivityLevel.lightlyActive:
        return 'Light exercise 1–3 days/week';
      case ActivityLevel.moderatelyActive:
        return 'Moderate exercise 3–5 days/week';
      case ActivityLevel.veryActive:
        return 'Hard exercise 6–7 days/week';
      case ActivityLevel.extraActive:
        return 'Very intense exercise or physically demanding work';
    }
  }

  double get multiplier {
    switch (this) {
      case ActivityLevel.sedentary:
        return 1.2;
      case ActivityLevel.lightlyActive:
        return 1.375;
      case ActivityLevel.moderatelyActive:
        return 1.55;
      case ActivityLevel.veryActive:
        return 1.725;
      case ActivityLevel.extraActive:
        return 1.9;
    }
  }
}

/// Enum representing elective calorie goals.
enum CalorieGoal {
  maintain,
  weightLoss,
  weightGain,
}

/// Extension on CalorieGoal to provide titles and daily calorie adjustments.
extension CalorieGoalExtension on CalorieGoal {
  String get title {
    switch (this) {
      case CalorieGoal.maintain:
        return 'Maintain weight';
      case CalorieGoal.weightLoss:
        return 'Gradual weight loss';
      case CalorieGoal.weightGain:
        return 'Gradual weight gain';
    }
  }

  String get subtitle {
    switch (this) {
      case CalorieGoal.maintain:
        return 'Match estimated daily energy expenditure';
      case CalorieGoal.weightLoss:
        return 'Mild deficit of -300 kcal/day';
      case CalorieGoal.weightGain:
        return 'Mild surplus of +300 kcal/day';
    }
  }

  double get calorieAdjustment {
    switch (this) {
      case CalorieGoal.maintain:
        return 0.0;
      case CalorieGoal.weightLoss:
        return -300.0;
      case CalorieGoal.weightGain:
        return 300.0;
    }
  }
}

/// Comprehensive structured model holding calculated BMI, metabolic rates, and health advice.
class CalculatorResult {
  final double bmi;
  final String bmiCategory;
  final String bmiAdvice;
  final double bmr;
  final double maintenanceCalories;
  /// Null when adult goal-based targets are not appropriate for this user.
  final double? goalCalories;
  final CalorieGoal selectedGoal;
  final ActivityLevel activityLevel;
  final Gender gender;
  final int age;
  final double weightKg;
  final double heightCm;
  final bool isUnder18;
  final String safetyMessage;
  final String generalDisclaimer;

  const CalculatorResult({
    required this.bmi,
    required this.bmiCategory,
    required this.bmiAdvice,
    required this.bmr,
    required this.maintenanceCalories,
    required this.goalCalories,
    required this.selectedGoal,
    required this.activityLevel,
    required this.gender,
    required this.age,
    required this.weightKg,
    required this.heightCm,
    required this.isUnder18,
    required this.safetyMessage,
    required this.generalDisclaimer,
  });

  /// Formatted BMI rounded to one decimal place.
  String get formattedBmi => bmi.toStringAsFixed(1);

  /// Formatted BMR rounded to the nearest integer.
  String get formattedBmr => '${bmr.round()} kcal/day';

  /// Formatted daily maintenance calories rounded to the nearest integer.
  String get formattedMaintenanceCalories =>
      '${maintenanceCalories.round()} kcal/day';

  /// Formatted goal calories rounded to the nearest integer.
  String? get formattedGoalCalories =>
      goalCalories == null ? null : '${goalCalories!.round()} kcal/day';
}
