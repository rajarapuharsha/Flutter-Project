import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import '../services/calculator_service.dart';
import '../theme/app_theme.dart';
import '../widgets/bmi_indicator.dart';
import '../widgets/input_form.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/result_card.dart';

/// Screen managing user measurements, form execution, calculation state,
/// responsive layout switching, and dynamic goal updates.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<InputFormState>();

  CalculatorResult? _result;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onCalculate({
    required int age,
    required BiologicalSex sex,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activityLevel,
    required CalorieGoal calorieGoal,
  }) {
    final result = CalculatorService.calculateAll(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
      calorieGoal: calorieGoal,
    );

    setState(() {
      _result = result;
    });

    // On narrow screens, scroll smoothly towards the results
    if (mounted && ResponsiveLayout.isMobile(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            520,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _onReset() {
    setState(() {
      _result = null;
    });
  }

  void _onGoalChanged(CalorieGoal newGoal) {
    if (_result != null) {
      setState(() {
        _result = _result!.copyWithGoal(newGoal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildSingleColumnLayout(context),
        desktop: _buildTwoColumnLayout(context),
      ),
    );
  }

  /// Single column layout for mobile and tablet devices
  Widget _buildSingleColumnLayout(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormCard(),
          const SizedBox(height: 20),
          _result != null ? _buildResultsSection(context) : _buildEmptyState(context),
        ],
      ),
    );
  }

  /// Two-column layout for desktop monitors and wide web windows
  Widget _buildTwoColumnLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Input Form
          Expanded(
            flex: 5,
            child: _buildFormCard(),
          ),
          const SizedBox(width: 24),

          // Right Column: Results or Empty State
          Expanded(
            flex: 6,
            child: _result != null ? _buildResultsSection(context) : _buildEmptyState(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryNavy.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.calculate, color: AppTheme.primaryNavy, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Measurement Input Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'Enter personal details to calculate metrics',
                        style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            InputForm(
              key: _formKey,
              onCalculate: _onCalculate,
              onReset: _onReset,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.analytics_outlined,
                size: 56,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Awaiting Your Measurements',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF334155),
                  ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Text(
                'Complete the form on the left with your age, sex, height, weight, and activity level, then press Calculate to generate your personal BMI and daily calorie profile.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF64748B),
                      height: 1.45,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection(BuildContext context) {
    final res = _result!;
    final categoryColor = AppTheme.getColorForCategory(res.bmiCategory);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Pediatric or Safety Notice Banner if present
        if (res.safetyNotice != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF1D4ED8), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    res.safetyNotice!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1E40AF),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // 1. BMI Metric Card & Visual Spectrum
        ResultCard(
          title: 'Body Mass Index (BMI)',
          value: res.bmiDisplay,
          unit: 'kg/m²',
          subtitle: res.isPediatric
              ? 'Pediatric screening (requires age-and-sex specific growth charts)'
              : 'WHO adult classification standard',
          accentColor: categoryColor,
          icon: Icons.monitor_weight_outlined,
          trailingBadge: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: categoryColor),
            ),
            child: Text(
              res.bmiCategory,
              style: TextStyle(
                color: categoryColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          child: BmiIndicator(
            bmi: res.bmi,
            category: res.bmiCategory,
            isPediatric: res.isPediatric,
          ),
        ),
        const SizedBox(height: 14),

        // 2. Basal Metabolic Rate (BMR) Card
        ResultCard(
          title: 'Basal Metabolic Rate (BMR)',
          value: '${res.bmrDisplay}',
          unit: 'kcal / day',
          subtitle: 'Calculated using the Mifflin-St Jeor equation (${res.sex.displayName} parameters). '
              'Represents baseline energy expended at complete physical rest.',
          icon: Icons.battery_charging_full_outlined,
          accentColor: AppTheme.primaryNavy,
        ),
        const SizedBox(height: 14),

        // 3. Maintenance Calories (TDEE) Card
        ResultCard(
          title: 'Daily Maintenance Calories (TDEE)',
          value: '${res.maintenanceCaloriesDisplay}',
          unit: 'kcal / day',
          subtitle: 'Energy required to maintain current body weight based on '
              '${res.activityLevel.displayName} multiplier (${res.activityLevel.multiplier}x).',
          icon: Icons.local_fire_department_outlined,
          accentColor: AppTheme.secondaryTeal,
        ),
        const SizedBox(height: 14),

        // 4. Calorie Objective Card (with dynamic switcher)
        if (!res.isPediatric && res.goalCaloriesDisplay != null) ...[
          ResultCard(
            title: 'Selected Weight Objective Target',
            value: '${res.goalCaloriesDisplay}',
            unit: 'kcal / day',
            subtitle: 'Illustrative arithmetic adjustment (${res.calorieGoal.calorieOffset >= 0 ? "+" : ""}${res.calorieGoal.calorieOffset} kcal/day). '
                'Adjusting targets gradually helps maintain metabolic health and lean muscle mass.',
            icon: Icons.flag_outlined,
            accentColor: AppTheme.primaryBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Switch Target Objective:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: CalorieGoal.values.map((goal) {
                    final isSelected = res.calorieGoal == goal;
                    return ChoiceChip(
                      label: Text(
                        goal.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppTheme.primaryNavy,
                      onSelected: (selected) {
                        if (selected) {
                          _onGoalChanged(goal);
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],

        // 5. Category-Specific Guidance & Lifestyle Insights
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.tips_and_updates_outlined, color: AppTheme.secondaryTeal, size: 22),
                    const SizedBox(width: 10),
                    const Text(
                      'Lifestyle & Nutrition Guidance',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  res.bmiAdvice,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'SDG 3 Healthy Living Tip:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF059669),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Prioritize nutrient-dense whole foods, maintain consistent hydration (2-3 L water daily), engage in at least 150 minutes of moderate cardiovascular activity weekly, and secure 7-9 hours of restorative sleep.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
