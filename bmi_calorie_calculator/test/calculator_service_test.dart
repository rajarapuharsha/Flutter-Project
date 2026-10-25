import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/models/calculator_result.dart';
import 'package:bmi_calorie_calculator/services/calculator_service.dart';

void main() {
  group('BMI Calculation Tests', () {
    test('Calculates BMI correctly for standard values', () {
      // 70 kg, 175 cm -> 70 / (1.75 * 1.75) = 22.85714...
      final bmi = CalculatorService.calculateBMI(70, 175);
      expect(bmi, closeTo(22.86, 0.01));
    });

    test('Throws ArgumentError for zero or negative height and weight', () {
      expect(() => CalculatorService.calculateBMI(70, 0), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(0, 170), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(-5, 170), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(70, -170), throwsArgumentError);
    });

    test('Classifies adult BMI categories accurately at boundary values', () {
      // Underweight: < 18.5
      expect(CalculatorService.getBMICategory(18.4), equals('Underweight'));

      // Boundary 18.5: Normal weight
      expect(CalculatorService.getBMICategory(18.5), equals('Normal weight'));
      expect(CalculatorService.getBMICategory(24.9), equals('Normal weight'));

      // Boundary 25.0: Overweight
      expect(CalculatorService.getBMICategory(25.0), equals('Overweight'));
      expect(CalculatorService.getBMICategory(29.9), equals('Overweight'));

      // Boundary 30.0: Obesity
      expect(CalculatorService.getBMICategory(30.0), equals('Obesity'));
      expect(CalculatorService.getBMICategory(35.2), equals('Obesity'));
    });

    test('Applies pediatric condition for age under 18', () {
      final category = CalculatorService.getBMICategory(22.0, isUnder18: true);
      final advice = CalculatorService.getBMIAdvice(22.0, isUnder18: true);

      expect(category, equals('Pediatric / Under 18'));
      expect(advice, contains('children and teenagers under 18'));
      expect(advice, contains('pediatrician'));
    });

    test('Returns appropriate advice for all adult BMI categories', () {
      expect(CalculatorService.getBMIAdvice(17.0), contains('underweight'));
      expect(CalculatorService.getBMIAdvice(22.0), contains('normal healthy weight'));
      expect(CalculatorService.getBMIAdvice(27.0), contains('overweight'));
      expect(CalculatorService.getBMIAdvice(33.0), contains('obesity'));
    });
  });

  group('BMR and Calorie Calculation Tests', () {
    test('Calculates male BMR accurately using Mifflin-St Jeor formula', () {
      // Formula: (10 * 70) + (6.25 * 175) - (5 * 30) + 5
      // 700 + 1093.75 - 150 + 5 = 1648.75
      final bmr = CalculatorService.calculateBMRMale(30, 70, 175);
      expect(bmr, equals(1648.75));
    });

    test('Calculates female BMR accurately using Mifflin-St Jeor formula', () {
      // Formula: (10 * 60) + (6.25 * 165) - (5 * 30) - 161
      // 600 + 1031.25 - 150 - 161 = 1320.25
      final bmr = CalculatorService.calculateBMRFemale(30, 60, 165);
      expect(bmr, equals(1320.25));
    });

    test('calculateBMR helper selects correct gender branch', () {
      final maleBmr = CalculatorService.calculateBMR(30, 70, 175, Gender.male);
      final femaleBmr =
          CalculatorService.calculateBMR(30, 70, 175, Gender.female);

      expect(maleBmr, equals(1648.75));
      // Female formula is 166 kcal less than male for same metrics (+5 vs -161)
      expect(femaleBmr, equals(1648.75 - 166));
    });

    test('Throws ArgumentError for non-positive BMR input parameters', () {
      expect(() => CalculatorService.calculateBMRMale(0, 70, 175),
          throwsArgumentError);
      expect(() => CalculatorService.calculateBMRFemale(25, -60, 165),
          throwsArgumentError);
      expect(() => CalculatorService.calculateBMRMale(25, 70, 0),
          throwsArgumentError);
    });

    test('Validates activity level multipliers', () {
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.sedentary),
          equals(1.2));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.lightlyActive),
          equals(1.375));
      expect(
          CalculatorService.getActivityMultiplier(ActivityLevel.moderatelyActive),
          equals(1.55));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.veryActive),
          equals(1.725));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.extraActive),
          equals(1.9));
    });

    test('Calculates maintenance daily calories (TDEE)', () {
      // 1600 BMR * 1.55 = 2480 kcal
      final calories = CalculatorService.calculateDailyCalories(1600, 1.55);
      expect(calories, equals(2480.0));
    });

    test('Calculates goal-adjusted calories accurately', () {
      const maintenance = 2500.0;

      // Maintain: 2500
      expect(
        CalculatorService.calculateGoalCalories(
            maintenance, CalorieGoal.maintain),
        equals(2500.0),
      );

      // Weight loss: -300 kcal
      expect(
        CalculatorService.calculateGoalCalories(
            maintenance, CalorieGoal.weightLoss),
        equals(2200.0),
      );

      // Weight gain: +300 kcal
      expect(
        CalculatorService.calculateGoalCalories(
            maintenance, CalorieGoal.weightGain),
        equals(2800.0),
      );
    });

    test('Comprehensive calculateAll returns complete structured model', () {
      final result = CalculatorService.calculateAll(
        age: 25,
        gender: Gender.male,
        heightCm: 180,
        weightKg: 75,
        activityLevel: ActivityLevel.moderatelyActive,
        calorieGoal: CalorieGoal.weightLoss,
      );

      // BMI: 75 / (1.8 * 1.8) = 23.148... -> 'Normal weight'
      expect(result.bmi, closeTo(23.15, 0.05));
      expect(result.bmiCategory, equals('Normal weight'));
      expect(result.isUnder18, isFalse);
      expect(result.formattedBmi, equals('23.1'));

      // BMR: (10*75) + (6.25*180) - (5*25) + 5 = 750 + 1125 - 125 + 5 = 1755
      expect(result.bmr, equals(1755.0));
      expect(result.formattedBmr, equals('1755 kcal/day'));

      // Maintenance: 1755 * 1.55 = 2720.25 -> round 2720
      expect(result.maintenanceCalories, equals(2720.25));
      expect(result.formattedMaintenanceCalories, equals('2720 kcal/day'));

      // Goal: 2720.25 - 300 = 2420.25 -> round 2420
      expect(result.goalCalories, equals(2420.25));
      expect(result.formattedGoalCalories, equals('2420 kcal/day'));
      expect(result.safetyMessage, isNotEmpty);
      expect(result.generalDisclaimer, isNotEmpty);
    });

    test('Withholds adult calorie goals for minors and special populations', () {
      CalculatorResult calculate({required int age, bool special = false}) =>
          CalculatorService.calculateAll(
            age: age,
            gender: Gender.female,
            heightCm: 165,
            weightKg: 60,
            activityLevel: ActivityLevel.moderatelyActive,
            calorieGoal: CalorieGoal.weightLoss,
            isSpecialPopulation: special,
          );

      expect(calculate(age: 17).goalCalories, isNull);
      expect(calculate(age: 30, special: true).goalCalories, isNull);
      expect(calculate(age: 30).goalCalories, isNotNull);
    });
  });
}
