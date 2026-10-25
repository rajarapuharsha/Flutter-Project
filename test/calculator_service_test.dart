import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/models/calculator_result.dart';
import 'package:bmi_calorie_calculator/services/calculator_service.dart';

void main() {
  group('CalculatorService - BMI Calculation & Classification', () {
    test('calculates correct BMI for known height and weight', () {
      // 70 kg, 175 cm -> 70 / (1.75 * 1.75) = 22.857142857142858
      final bmi = CalculatorService.calculateBMI(70, 175);
      expect(bmi, closeTo(22.857, 0.001));
    });

    test('classifies Underweight correctly below 18.5', () {
      expect(CalculatorService.getBMICategory(18.49), 'Underweight');
      expect(CalculatorService.getBMICategory(15.0), 'Underweight');
    });

    test('classifies Normal weight boundary at 18.5 up to 24.99', () {
      expect(CalculatorService.getBMICategory(18.5), 'Normal weight');
      expect(CalculatorService.getBMICategory(22.0), 'Normal weight');
      expect(CalculatorService.getBMICategory(24.99), 'Normal weight');
    });

    test('classifies Overweight boundary at 25.0 up to 29.99', () {
      expect(CalculatorService.getBMICategory(25.0), 'Overweight');
      expect(CalculatorService.getBMICategory(27.5), 'Overweight');
      expect(CalculatorService.getBMICategory(29.99), 'Overweight');
    });

    test('classifies Obesity boundary at 30.0 and above', () {
      expect(CalculatorService.getBMICategory(30.0), 'Obesity');
      expect(CalculatorService.getBMICategory(38.5), 'Obesity');
    });

    test('throws ArgumentError for invalid height or weight', () {
      expect(() => CalculatorService.calculateBMI(70, 0), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(70, -170), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(0, 170), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(-60, 170), throwsArgumentError);
    });

    test('returns appropriate non-diagnostic advice per category', () {
      expect(CalculatorService.getBMIAdvice(17.0), contains('below the standard'));
      expect(CalculatorService.getBMIAdvice(22.0), contains('healthy adult range'));
      expect(CalculatorService.getBMIAdvice(27.0), contains('sustainable lifestyle habits'));
      expect(CalculatorService.getBMIAdvice(33.0), contains('obesity classification'));
    });

    test('returns pediatric advice when isPediatric is true', () {
      final advice = CalculatorService.getBMIAdvice(22.0, isPediatric: true);
      expect(advice, contains('under 18'));
      expect(advice, contains('pediatrician'));
    });
  });

  group('CalculatorService - Mifflin-St Jeor BMR Calculations', () {
    test('calculates male BMR correctly', () {
      // (10 * 70) + (6.25 * 175) - (5 * 25) + 5 = 700 + 1093.75 - 125 + 5 = 1673.75
      final bmr = CalculatorService.calculateBMRMale(25, 70, 175);
      expect(bmr, equals(1673.75));
    });

    test('calculates female BMR correctly', () {
      // (10 * 70) + (6.25 * 175) - (5 * 25) - 161 = 700 + 1093.75 - 125 - 161 = 1507.75
      final bmr = CalculatorService.calculateBMRFemale(25, 70, 175);
      expect(bmr, equals(1507.75));
    });

    test('throws ArgumentError for invalid BMR inputs', () {
      expect(() => CalculatorService.calculateBMRMale(0, 70, 175), throwsArgumentError);
      expect(() => CalculatorService.calculateBMRMale(25, 0, 175), throwsArgumentError);
      expect(() => CalculatorService.calculateBMRMale(25, 70, 0), throwsArgumentError);
      expect(() => CalculatorService.calculateBMRFemale(-5, 60, 160), throwsArgumentError);
    });
  });

  group('CalculatorService - Physical Activity Multipliers & TDEE', () {
    test('returns exact multipliers for all 5 activity levels', () {
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.sedentary), equals(1.2));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.lightlyActive), equals(1.375));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.moderatelyActive), equals(1.55));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.veryActive), equals(1.725));
      expect(CalculatorService.getActivityMultiplier(ActivityLevel.extraActive), equals(1.9));
    });

    test('calculates daily maintenance calories (BMR * Multiplier)', () {
      const bmr = 1600.0;
      final tdee = CalculatorService.calculateDailyCalories(bmr, 1.55);
      expect(tdee, equals(2480.0));
    });

    test('throws ArgumentError for non-positive BMR or multiplier', () {
      expect(() => CalculatorService.calculateDailyCalories(0, 1.2), throwsArgumentError);
      expect(() => CalculatorService.calculateDailyCalories(1500, 0), throwsArgumentError);
      expect(() => CalculatorService.calculateDailyCalories(-1500, 1.5), throwsArgumentError);
    });
  });

  group('CalculatorService - Goal Calorie Adjustments & Pediatric Rules', () {
    test('calculates maintenance, loss (-300), and gain (+300) for adults', () {
      const maintenance = 2500.0;

      final maintain = CalculatorService.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.maintain,
        isPediatric: false,
      );
      expect(maintain, equals(2500.0));

      final loss = CalculatorService.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.gradualLoss,
        isPediatric: false,
      );
      expect(loss, equals(2200.0));

      final gain = CalculatorService.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.gradualGain,
        isPediatric: false,
      );
      expect(gain, equals(2800.0));
    });

    test('withholds goal calorie targets for pediatric users (<18 yrs)', () {
      final pediatricGoal = CalculatorService.calculateGoalCalories(
        maintenanceCalories: 2000.0,
        goal: CalorieGoal.gradualLoss,
        isPediatric: true,
      );
      expect(pediatricGoal, isNull);
    });

    test('withholds goal calorie targets if result is unfeasibly low (< 500 kcal)', () {
      final invalidGoal = CalculatorService.calculateGoalCalories(
        maintenanceCalories: 600.0,
        goal: CalorieGoal.gradualLoss, // 600 - 300 = 300 (< 500)
        isPediatric: false,
      );
      expect(invalidGoal, isNull);
    });
  });

  group('CalculatorService - calculateAll Orchestration', () {
    test('produces comprehensive valid adult CalculatorResult', () {
      final result = CalculatorService.calculateAll(
        age: 28,
        sex: BiologicalSex.male,
        heightCm: 180,
        weightKg: 75,
        activityLevel: ActivityLevel.moderatelyActive,
        calorieGoal: CalorieGoal.maintain,
      );

      expect(result.bmi, closeTo(23.15, 0.01));
      expect(result.bmiCategory, 'Normal weight');
      expect(result.bmr, equals(1730.0));
      expect(result.maintenanceCalories, equals(2681.5));
      expect(result.goalCalories, equals(2681.5));
      expect(result.isPediatric, isFalse);
      expect(result.safetyNotice, isNull);
    });

    test('flags pediatric users and attaches safety notice', () {
      final result = CalculatorService.calculateAll(
        age: 15,
        sex: BiologicalSex.female,
        heightCm: 160,
        weightKg: 50,
        activityLevel: ActivityLevel.lightlyActive,
        calorieGoal: CalorieGoal.gradualLoss,
      );

      expect(result.isPediatric, isTrue);
      expect(result.bmiCategory, contains('Pediatric'));
      expect(result.goalCalories, isNull);
      expect(result.safetyNotice, isNotNull);
      expect(result.safetyNotice, contains('under 18'));
    });

    test('copyWithGoal correctly modifies adult calorie goal without recalculating inputs', () {
      final initial = CalculatorService.calculateAll(
        age: 30,
        sex: BiologicalSex.male,
        heightCm: 175,
        weightKg: 70,
        activityLevel: ActivityLevel.sedentary,
        calorieGoal: CalorieGoal.maintain,
      );

      final withLoss = initial.copyWithGoal(CalorieGoal.gradualLoss);
      expect(withLoss.calorieGoal, CalorieGoal.gradualLoss);
      expect(withLoss.goalCalories, equals(initial.maintenanceCalories - 300));
    });
  });
}
