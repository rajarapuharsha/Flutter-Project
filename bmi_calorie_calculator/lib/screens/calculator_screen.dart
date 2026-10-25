import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import '../services/calculator_service.dart';
import '../theme/app_theme.dart';
import '../widgets/input_form.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/result_card.dart';

/// Screen where users input their metrics and view calculated BMI and calorie insights.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _resultsKey = GlobalKey();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Gender? _selectedGender = Gender.male;
  ActivityLevel? _selectedActivityLevel = ActivityLevel.moderatelyActive;
  CalorieGoal _selectedCalorieGoal = CalorieGoal.maintain;
  bool _isSpecialPopulation = false;

  CalculatorResult? _calculationResult;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleCalculate() {
    // Dismiss soft keyboard
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted errors in the form.'),
          backgroundColor: AppTheme.bmiObesity,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your biological gender.'),
          backgroundColor: AppTheme.bmiObesity,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedActivityLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your daily activity level.'),
          backgroundColor: AppTheme.bmiObesity,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final age = int.parse(_ageController.text.trim());
    final height = double.parse(_heightController.text.trim());
    final weight = double.parse(_weightController.text.trim());

    final result = CalculatorService.calculateAll(
      age: age,
      gender: _selectedGender!,
      heightCm: height,
      weightKg: weight,
      activityLevel: _selectedActivityLevel!,
      calorieGoal: _selectedCalorieGoal,
      isSpecialPopulation: _isSpecialPopulation,
    );

    setState(() {
      _calculationResult = result;
    });

    // On mobile, scroll smoothly down to the results section
    if (ResponsiveLayout.isMobile(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = _resultsKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _handleReset() {
    _formKey.currentState?.reset();
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();

    setState(() {
      _selectedGender = Gender.male;
      _selectedActivityLevel = ActivityLevel.moderatelyActive;
      _selectedCalorieGoal = CalorieGoal.maintain;
      _isSpecialPopulation = false;
      _calculationResult = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All form fields and results have been cleared.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI & Calorie Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset Form',
            onPressed: _handleReset,
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(),
          tablet: _buildTabletLayout(),
          desktop: _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlueLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.health_and_safety_rounded,
            size: 36,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'BMI & CALORIE CALCULATOR',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Understand your BMI and estimated daily energy needs.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: InputForm(
                formKey: _formKey,
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                selectedGender: _selectedGender,
                selectedActivityLevel: _selectedActivityLevel,
                selectedCalorieGoal: _selectedCalorieGoal,
                isSpecialPopulation: _isSpecialPopulation,
                onGenderChanged: (val) => setState(() => _selectedGender = val),
                onActivityLevelChanged: (val) =>
                    setState(() => _selectedActivityLevel = val),
                onCalorieGoalChanged: (val) =>
                    setState(() => _selectedCalorieGoal = val),
                onSpecialPopulationChanged: (val) =>
                    setState(() => _isSpecialPopulation = val),
                onCalculate: _handleCalculate,
                onReset: _handleReset,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            key: _resultsKey,
            child: ResultCard(result: _calculationResult),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 28),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: InputForm(
                formKey: _formKey,
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                selectedGender: _selectedGender,
                selectedActivityLevel: _selectedActivityLevel,
                selectedCalorieGoal: _selectedCalorieGoal,
                isSpecialPopulation: _isSpecialPopulation,
                onGenderChanged: (val) => setState(() => _selectedGender = val),
                onActivityLevelChanged: (val) =>
                    setState(() => _selectedActivityLevel = val),
                onCalorieGoalChanged: (val) =>
                    setState(() => _selectedCalorieGoal = val),
                onSpecialPopulationChanged: (val) =>
                    setState(() => _isSpecialPopulation = val),
                onCalculate: _handleCalculate,
                onReset: _handleReset,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            key: _resultsKey,
            child: ResultCard(result: _calculationResult),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: User Input Form
              Expanded(
                flex: 5,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: InputForm(
                      formKey: _formKey,
                      ageController: _ageController,
                      heightController: _heightController,
                      weightController: _weightController,
                      selectedGender: _selectedGender,
                      selectedActivityLevel: _selectedActivityLevel,
                      selectedCalorieGoal: _selectedCalorieGoal,
                      isSpecialPopulation: _isSpecialPopulation,
                      onGenderChanged: (val) =>
                          setState(() => _selectedGender = val),
                      onActivityLevelChanged: (val) =>
                          setState(() => _selectedActivityLevel = val),
                      onCalorieGoalChanged: (val) =>
                          setState(() => _selectedCalorieGoal = val),
                      onSpecialPopulationChanged: (val) =>
                          setState(() => _isSpecialPopulation = val),
                      onCalculate: _handleCalculate,
                      onReset: _handleReset,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Right Column: Results Section
              Expanded(
                flex: 6,
                child: ResultCard(result: _calculationResult),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
