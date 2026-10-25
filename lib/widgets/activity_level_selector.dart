import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import '../theme/app_theme.dart';

/// An accessible selector widget for choosing physical activity levels
/// with clear multipliers and contextual descriptions.
class ActivityLevelSelector extends StatelessWidget {
  final ActivityLevel selectedLevel;
  final ValueChanged<ActivityLevel> onChanged;

  const ActivityLevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onChanged,
  });

  IconData _getIconForLevel(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return Icons.weekend_outlined;
      case ActivityLevel.lightlyActive:
        return Icons.directions_walk_outlined;
      case ActivityLevel.moderatelyActive:
        return Icons.fitness_center_outlined;
      case ActivityLevel.veryActive:
        return Icons.directions_run_outlined;
      case ActivityLevel.extraActive:
        return Icons.sports_mma_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.speed_outlined, size: 20, color: AppTheme.primaryNavy),
            const SizedBox(width: 8),
            Text(
              'Activity Level (TDEE Factor)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ActivityLevel>(
              value: selectedLevel,
              dropdownColor: const Color(0xFF1E293B),
              isExpanded: true,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: ActivityLevel.values.map((level) {
                return DropdownMenuItem<ActivityLevel>(
                  value: level,
                  child: Row(
                    children: [
                      Icon(
                        _getIconForLevel(level),
                        size: 20,
                        color: level == selectedLevel
                            ? const Color(0xFF60A5FA)
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${level.displayName} (${level.multiplier}x)',
                              style: TextStyle(
                                fontWeight: level == selectedLevel
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              level.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (level) {
                if (level != null) {
                  onChanged(level);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
