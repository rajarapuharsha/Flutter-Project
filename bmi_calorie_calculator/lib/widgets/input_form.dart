import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/calculator_result.dart';
import '../theme/app_theme.dart';
import '../utils/input_validator.dart';
import 'activity_level_selector.dart';

/// Interactive form gathering personal metrics, activity level, and calorie goals.
class InputForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final Gender? selectedGender;
  final ActivityLevel? selectedActivityLevel;
  final CalorieGoal selectedCalorieGoal;
  final bool isSpecialPopulation;

  final ValueChanged<Gender> onGenderChanged;
  final ValueChanged<ActivityLevel> onActivityLevelChanged;
  final ValueChanged<CalorieGoal> onCalorieGoalChanged;
  final ValueChanged<bool> onSpecialPopulationChanged;
  final VoidCallback onCalculate;
  final VoidCallback onReset;

  const InputForm({
    Key? key,
    required this.formKey,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.selectedGender,
    required this.selectedActivityLevel,
    required this.selectedCalorieGoal,
    required this.isSpecialPopulation,
    required this.onGenderChanged,
    required this.onActivityLevelChanged,
    required this.onCalorieGoalChanged,
    required this.onSpecialPopulationChanged,
    required this.onCalculate,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1: Biological Gender Selection
          const Text(
            'Biological Gender',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Used for the Mifflin-St Jeor metabolic baseline formula.',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _GenderCard(
                  title: 'Male',
                  icon: Icons.male_rounded,
                  isSelected: selectedGender == Gender.male,
                  onTap: () => onGenderChanged(Gender.male),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GenderCard(
                  title: 'Female',
                  icon: Icons.female_rounded,
                  isSelected: selectedGender == Gender.female,
                  onTap: () => onGenderChanged(Gender.female),
                ),
              ),
            ],
          ),
          if (selectedGender == null) ...[
            const SizedBox(height: 6),
            const Text(
              'Please select biological gender',
              style: TextStyle(
                color: AppTheme.bmiObesity,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 20),

          // Section 2: Personal Metrics (Age, Height, Weight)
          const Text(
            'Body Measurements',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Age Field
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Age (years)',
              hintText: 'e.g. 28',
              prefixIcon: Icon(Icons.cake_outlined, color: AppTheme.textSecondary),
            ),
            validator: InputValidator.validateAge,
          ),
          const SizedBox(height: 14),

          // Height & Weight Fields in a responsive row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: heightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    hintText: 'e.g. 175',
                    prefixIcon:
                        Icon(Icons.height_rounded, color: AppTheme.textSecondary),
                  ),
                  validator: InputValidator.validateHeight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: weightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    hintText: 'e.g. 70.5',
                    prefixIcon: Icon(Icons.monitor_weight_outlined,
                        color: AppTheme.textSecondary),
                  ),
                  validator: InputValidator.validateWeight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section 3: Daily Activity Level
          ActivityLevelSelector(
            selectedLevel: selectedActivityLevel,
            onChanged: onActivityLevelChanged,
          ),
          const SizedBox(height: 20),

          // Section 4: Calorie Goal Selection
          const Text(
            'Calorie Goal (Optional Focus)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Select your personal health direction:',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 10),
          ...CalorieGoal.values.map((goal) {
            final isSelected = selectedCalorieGoal == goal;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () => onCalorieGoalChanged(goal),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.secondaryGreenLight.withOpacity(0.3)
                        : AppTheme.cardSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.secondaryGreen
                          : AppTheme.borderLight,
                      width: isSelected ? 1.8 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio<CalorieGoal>(
                        value: goal,
                        groupValue: selectedCalorieGoal,
                        activeColor: AppTheme.secondaryGreen,
                        onChanged: (val) {
                          if (val != null) onCalorieGoalChanged(val);
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppTheme.secondaryGreenDark
                                    : AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              goal.subtitle,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 14),

          // Special Population Switch (Pregnancy / Nursing / Medical note)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.medical_information_outlined,
                  size: 22,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pregnancy, Nursing, or Clinical Condition',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Standard adult targets will be replaced with medical consultation notices.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: isSpecialPopulation,
                  activeColor: AppTheme.primaryBlue,
                  onChanged: onSpecialPopulationChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons: Calculate & Reset
          ElevatedButton.icon(
            onPressed: onCalculate,
            icon: const Icon(Icons.calculate_rounded),
            label: const Text('CALCULATE BMI & CALORIES'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reset All Inputs'),
          ),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlueLight.withOpacity(0.5)
              : AppTheme.cardSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.borderLight,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppTheme.primaryBlueDark
                    : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
