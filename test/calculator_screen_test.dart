import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/screens/calculator_screen.dart';
import 'package:bmi_calorie_calculator/theme/app_theme.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const CalculatorScreen(),
    );
  }

  group('CalculatorScreen Widget Tests', () {
    testWidgets('renders initial measurement input form and empty state awaiting input', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Check header and form labels
      expect(find.text('Measurement Input Form'), findsOneWidget);
      expect(find.text('Age (years)'), findsOneWidget);
      expect(find.text('Biological Sex'), findsOneWidget);
      expect(find.text('Height (cm)'), findsOneWidget);
      expect(find.text('Weight (kg)'), findsOneWidget);

      // Check Action Buttons
      expect(find.text('Calculate'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);

      // Check Empty State
      expect(find.text('Awaiting Your Measurements'), findsOneWidget);
    });

    testWidgets('displays validation error messages when fields are left empty and Calculate is tapped', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap calculate without entering any inputs
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your age.'), findsOneWidget);
      expect(find.text('Please enter your height.'), findsOneWidget);
      expect(find.text('Please enter your weight.'), findsOneWidget);
      expect(find.text('Body Mass Index (BMI)'), findsNothing);
    });

    testWidgets('performs calculation, shows result cards, BMI indicator, and reset clears state', (tester) async {
      // Set test surface size to ensure both columns fit nicely
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createWidgetUnderTest());

      // Fill in valid measurements
      final ageField = find.widgetWithText(TextFormField, 'Age (years)');
      final heightField = find.widgetWithText(TextFormField, 'Height (cm)');
      final weightField = find.widgetWithText(TextFormField, 'Weight (kg)');

      await tester.enterText(ageField, '25');
      await tester.enterText(heightField, '175');
      await tester.enterText(weightField, '70');
      await tester.pumpAndSettle();

      // Tap Calculate
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Verify results are rendered
      expect(find.text('Body Mass Index (BMI)'), findsOneWidget);
      expect(find.text('22.9'), findsOneWidget);
      expect(find.text('Normal weight'), findsWidgets);
      expect(find.text('Basal Metabolic Rate (BMR)'), findsOneWidget);
      expect(find.text('Daily Maintenance Calories (TDEE)'), findsOneWidget);

      // Verify empty state is gone
      expect(find.text('Awaiting Your Measurements'), findsNothing);

      // Tap Reset button
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Verify cleared state
      expect(find.text('Body Mass Index (BMI)'), findsNothing);
      expect(find.text('Awaiting Your Measurements'), findsOneWidget);
    });

    testWidgets('displays pediatric notice when age is under 18', (tester) async {
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createWidgetUnderTest());

      final ageField = find.widgetWithText(TextFormField, 'Age (years)');
      final heightField = find.widgetWithText(TextFormField, 'Height (cm)');
      final weightField = find.widgetWithText(TextFormField, 'Weight (kg)');

      await tester.enterText(ageField, '14');
      await tester.enterText(heightField, '155');
      await tester.enterText(weightField, '48');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Check pediatric notice is displayed
      expect(find.textContaining('Age is under 18 years'), findsOneWidget);
      expect(find.textContaining('Pediatric Profile'), findsOneWidget);
    });
  });
}
