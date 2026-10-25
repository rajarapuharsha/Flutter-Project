import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import '../theme/app_theme.dart';

/// Interactive selector widget for choosing user physical activity level.
class ActivityLevelSelector extends StatelessWidget {
  final ActivityLevel? selectedLevel;
  final ValueChanged<ActivityLevel> onChanged;

  const ActivityLevelSelector({
    Key? key,
    required this.selectedLevel,
    required this.onChanged,
  }) : super(key: key);

  IconData _getIconForLevel(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return Icons.weekend_outlined;
      case ActivityLevel.lightlyActive:
        return Icons.directions_walk_outlined;
      case ActivityLevel.moderatelyActive:
        return Icons.directions_run_outlined;
      case ActivityLevel.veryActive:
        return Icons.fitness_center_outlined;
      case ActivityLevel.extraActive:
        return Icons.bolt_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Activity Level',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Choose the option that closest represents your weekly routine:',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 10),

        // List of selectable activity cards
        ...ActivityLevel.values.map((level) {
          final isSelected = selectedLevel == level;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () => onChanged(level),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryBlueLight.withOpacity(0.4)
                      : AppTheme.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryBlue
                        : AppTheme.borderLight,
                    width: isSelected ? 1.8 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.surfaceMuted,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getIconForLevel(level),
                        color: isSelected
                            ? Colors.white
                            : AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Title & Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                level.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppTheme.primaryBlueDark
                                      : AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceMuted,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '×${level.multiplier}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            level.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Radio indicator
                    Radio<ActivityLevel>(
                      value: level,
                      groupValue: selectedLevel,
                      activeColor: AppTheme.primaryBlue,
                      onChanged: (val) {
                        if (val != null) onChanged(val);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
