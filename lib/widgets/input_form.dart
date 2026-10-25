import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import '../theme/app_theme.dart';
import '../utils/input_validator.dart';
import 'activity_level_selector.dart';

/// Reusable input form widget handling measurement data entry, validation,
/// biological sex selection, activity levels, and calculation/reset callbacks.
class InputForm extends StatefulWidget {
  final void Function({
    required int age,
    required BiologicalSex sex,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activityLevel,
    required CalorieGoal calorieGoal,
  }) onCalculate;

  final VoidCallback onReset;

  const InputForm({
    super.key,
    required this.onCalculate,
    required this.onReset,
  });

  @override
  State<InputForm> createState() => InputFormState();
}

class InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  BiologicalSex _selectedSex = BiologicalSex.male;
  ActivityLevel _selectedActivity = ActivityLevel.moderatelyActive;
  CalorieGoal _selectedGoal = CalorieGoal.maintain;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  /// Clears form fields, resets dropdowns, clears validation errors and triggers reset callback
  void reset() {
    _formKey.currentState?.reset();
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _selectedSex = BiologicalSex.male;
      _selectedActivity = ActivityLevel.moderatelyActive;
      _selectedGoal = CalorieGoal.maintain;
    });
    widget.onReset();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final age = int.parse(_ageController.text.trim());
      final heightCm = double.parse(_heightController.text.trim());
      final weightKg = double.parse(_weightController.text.trim());

      widget.onCalculate(
        age: age,
        sex: _selectedSex,
        heightCm: heightCm,
        weightKg: weightKg,
        activityLevel: _selectedActivity,
        calorieGoal: _selectedGoal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1: Personal Profile
          _buildSectionHeader('1. Personal Profile', Icons.person_outline),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Age Input
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Age (years)',
                    hintText: 'e.g. 25',
                    prefixIcon: Icon(Icons.cake_outlined),
                    filled: true,
                    fillColor: Color(0xFF1E293B),
                    labelStyle: TextStyle(color: Color(0xFF94A3B8)),
                    hintStyle: TextStyle(color: Color(0xFF64748B)),
                    prefixIconColor: Color(0xFF94A3B8),
                  ),
                  validator: InputValidator.validateAge,
                ),
              ),
              const SizedBox(width: 14),

              // Biological Sex Selector
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biological Sex',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 52,
                      child: SegmentedButton<BiologicalSex>(
                        segments: const [
                          ButtonSegment(
                            value: BiologicalSex.male,
                            label: Text('Male'),
                            icon: Icon(Icons.male, size: 18),
                          ),
                          ButtonSegment(
                            value: BiologicalSex.female,
                            label: Text('Female'),
                            icon: Icon(Icons.female, size: 18),
                          ),
                        ],
                        selected: {_selectedSex},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _selectedSex = newSelection.first;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section 2: Body Measurements
          _buildSectionHeader('2. Body Measurements', Icons.straighten_outlined),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Height Input (cm)
              Expanded(
                child: TextFormField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    hintText: 'e.g. 175.0',
                    prefixIcon: Icon(Icons.height),
                    suffixText: 'cm',
                    suffixStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Color(0xFF1E293B),
                    labelStyle: TextStyle(color: Color(0xFF94A3B8)),
                    hintStyle: TextStyle(color: Color(0xFF64748B)),
                    prefixIconColor: Color(0xFF94A3B8),
                  ),
                  validator: InputValidator.validateHeight,
                ),
              ),
              const SizedBox(width: 14),

              // Weight Input (kg)
              Expanded(
                child: TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    hintText: 'e.g. 70.5',
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                    suffixText: 'kg',
                    suffixStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Color(0xFF1E293B),
                    labelStyle: TextStyle(color: Color(0xFF94A3B8)),
                    hintStyle: TextStyle(color: Color(0xFF64748B)),
                    prefixIconColor: Color(0xFF94A3B8),
                  ),
                  validator: InputValidator.validateWeight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section 3: Physical Activity Level
          _buildSectionHeader('3. Daily Physical Activity', Icons.directions_run_outlined),
          const SizedBox(height: 12),
          ActivityLevelSelector(
            selectedLevel: _selectedActivity,
            onChanged: (newLevel) {
              setState(() {
                _selectedActivity = newLevel;
              });
            },
          ),
          const SizedBox(height: 20),

          // Section 4: Caloric Goal (Weight Management)
          _buildSectionHeader('4. Caloric Objective', Icons.flag_outlined),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CalorieGoal.values.map((goal) {
              final isSelected = _selectedGoal == goal;
              return ChoiceChip(
                label: Text(
                  goal == CalorieGoal.maintain
                      ? 'Maintain Weight'
                      : goal == CalorieGoal.gradualLoss
                          ? 'Gradual Loss (-300 kcal)'
                          : 'Gradual Gain (+300 kcal)',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                selected: isSelected,
                selectedColor: AppTheme.primaryNavy,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedGoal = goal;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 26),

          // Action Buttons: Calculate & Reset
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Calculate'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.refresh_outlined),
                  label: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.secondaryTeal),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF334155),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
