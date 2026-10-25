import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/utils/input_validator.dart';

void main() {
  group('InputValidator - Age Validation', () {
    test('rejects empty or null age values', () {
      expect(InputValidator.validateAge(null), 'Please enter your age.');
      expect(InputValidator.validateAge(''), 'Please enter your age.');
      expect(InputValidator.validateAge('   '), 'Please enter your age.');
    });

    test('rejects non-integer age values', () {
      expect(InputValidator.validateAge('abc'), 'Please enter a valid whole number for age.');
      expect(InputValidator.validateAge('25.5'), 'Please enter a valid whole number for age.');
    });

    test('enforces age boundary limits [2, 120]', () {
      expect(InputValidator.validateAge('1'), contains('between 2 and 120'));
      expect(InputValidator.validateAge('121'), contains('between 2 and 120'));
      expect(InputValidator.validateAge('2'), isNull);
      expect(InputValidator.validateAge('25'), isNull);
      expect(InputValidator.validateAge('120'), isNull);
    });
  });

  group('InputValidator - Height Validation', () {
    test('rejects empty or null height values', () {
      expect(InputValidator.validateHeight(null), 'Please enter your height.');
      expect(InputValidator.validateHeight(''), 'Please enter your height.');
      expect(InputValidator.validateHeight('   '), 'Please enter your height.');
    });

    test('rejects non-numeric values', () {
      expect(InputValidator.validateHeight('xyz'), 'Please enter a valid number for height.');
    });

    test('rejects zero or negative height values', () {
      expect(InputValidator.validateHeight('0'), 'Height must be greater than zero.');
      expect(InputValidator.validateHeight('-10'), 'Height must be greater than zero.');
    });

    test('enforces height boundary limits [50.0, 260.0]', () {
      expect(InputValidator.validateHeight('49.9'), contains('between 50.0 and 260.0'));
      expect(InputValidator.validateHeight('260.1'), contains('between 50.0 and 260.0'));
      expect(InputValidator.validateHeight('50.0'), isNull);
      expect(InputValidator.validateHeight('175.5'), isNull);
      expect(InputValidator.validateHeight('260.0'), isNull);
    });
  });

  group('InputValidator - Weight Validation', () {
    test('rejects empty or null weight values', () {
      expect(InputValidator.validateWeight(null), 'Please enter your weight.');
      expect(InputValidator.validateWeight(''), 'Please enter your weight.');
      expect(InputValidator.validateWeight('   '), 'Please enter your weight.');
    });

    test('rejects non-numeric values', () {
      expect(InputValidator.validateWeight('abc'), 'Please enter a valid number for weight.');
    });

    test('rejects zero or negative weight values', () {
      expect(InputValidator.validateWeight('0'), 'Weight must be greater than zero.');
      expect(InputValidator.validateWeight('-5'), 'Weight must be greater than zero.');
    });

    test('enforces weight boundary limits [10.0, 400.0]', () {
      expect(InputValidator.validateWeight('9.9'), contains('between 10.0 and 400.0'));
      expect(InputValidator.validateWeight('400.1'), contains('between 10.0 and 400.0'));
      expect(InputValidator.validateWeight('10.0'), isNull);
      expect(InputValidator.validateWeight('70.5'), isNull);
      expect(InputValidator.validateWeight('400.0'), isNull);
    });
  });
}
