import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/models/calculator_result.dart';
import 'package:bmi_calorie_calculator/utils/input_validator.dart';

void main() {
  group('Age Validation Tests', () {
    test('Rejects null or empty age strings', () {
      expect(InputValidator.validateAge(null), equals('Please enter your age.'));
      expect(InputValidator.validateAge(''), equals('Please enter your age.'));
      expect(InputValidator.validateAge('   '), equals('Please enter your age.'));
    });

    test('Rejects non-integer or decimal age', () {
      expect(
        InputValidator.validateAge('abc'),
        equals('Please enter a valid whole number for age.'),
      );
      expect(
        InputValidator.validateAge('25.5'),
        equals('Please enter a valid whole number for age.'),
      );
    });

    test('Rejects zero and negative age', () {
      expect(InputValidator.validateAge('0'), equals('Age must be greater than 0.'));
      expect(InputValidator.validateAge('-5'), equals('Age must be greater than 0.'));
    });

    test('Accepts a positive age of 1 and rejects out-of-range ages', () {
      expect(InputValidator.validateAge('1'), isNull);
      expect(
        InputValidator.validateAge('135'),
        equals('Age must be between 1 and 120 years.'),
      );
    });

    test('Accepts valid age values', () {
      expect(InputValidator.validateAge('25'), isNull);
      expect(InputValidator.validateAge('18'), isNull);
      expect(InputValidator.validateAge('80'), isNull);
    });
  });

  group('Height Validation Tests', () {
    test('Rejects null or empty height strings', () {
      expect(
        InputValidator.validateHeight(null),
        equals('Please enter your height.'),
      );
      expect(
        InputValidator.validateHeight(''),
        equals('Please enter your height.'),
      );
    });

    test('Rejects non-numeric height strings', () {
      expect(
        InputValidator.validateHeight('tall'),
        equals('Please enter a valid numeric height.'),
      );
    });

    test('Rejects zero and negative height (prevents division by zero)', () {
      expect(
        InputValidator.validateHeight('0'),
        equals('Height must be greater than zero.'),
      );
      expect(
        InputValidator.validateHeight('-170'),
        equals('Height must be greater than zero.'),
      );
    });

    test('Rejects heights outside realistic biological boundaries', () {
      expect(
        InputValidator.validateHeight('45'),
        equals('Height must be between 50 cm and 250 cm.'),
      );
      expect(
        InputValidator.validateHeight('280'),
        equals('Height must be between 50 cm and 250 cm.'),
      );
    });

    test('Accepts valid integer and decimal heights', () {
      expect(InputValidator.validateHeight('175'), isNull);
      expect(InputValidator.validateHeight('165.5'), isNull);
      expect(InputValidator.validateHeight('192.3'), isNull);
    });
  });

  group('Weight Validation Tests', () {
    test('Rejects null or empty weight strings', () {
      expect(
        InputValidator.validateWeight(null),
        equals('Please enter your weight.'),
      );
      expect(
        InputValidator.validateWeight(''),
        equals('Please enter your weight.'),
      );
    });

    test('Rejects non-numeric weight strings', () {
      expect(
        InputValidator.validateWeight('heavy'),
        equals('Please enter a valid numeric weight.'),
      );
    });

    test('Rejects zero and negative weight', () {
      expect(
        InputValidator.validateWeight('0'),
        equals('Weight must be greater than zero.'),
      );
      expect(
        InputValidator.validateWeight('-65'),
        equals('Weight must be greater than zero.'),
      );
    });

    test('Rejects weights outside realistic biological boundaries', () {
      expect(
        InputValidator.validateWeight('5'),
        equals('Weight must be between 10 kg and 300 kg.'),
      );
      expect(
        InputValidator.validateWeight('350'),
        equals('Weight must be between 10 kg and 300 kg.'),
      );
    });

    test('Accepts valid integer and decimal weights', () {
      expect(InputValidator.validateWeight('70'), isNull);
      expect(InputValidator.validateWeight('68.5'), isNull);
      expect(InputValidator.validateWeight('110.2'), isNull);
    });
  });

  group('Selection Validation Tests', () {
    test('Validates gender selection', () {
      expect(
        InputValidator.validateGender(null),
        equals('Please select your biological gender.'),
      );
      expect(InputValidator.validateGender(Gender.male), isNull);
      expect(InputValidator.validateGender(Gender.female), isNull);
    });

    test('Validates activity level selection', () {
      expect(
        InputValidator.validateActivityLevel(null),
        equals('Please select your activity level.'),
      );
      expect(
        InputValidator.validateActivityLevel(ActivityLevel.sedentary),
        isNull,
      );
      expect(
        InputValidator.validateActivityLevel(ActivityLevel.moderatelyActive),
        isNull,
      );
    });
  });
}
