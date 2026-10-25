import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A visual, colored BMI scale indicator showing categories and the user's position.
class BmiIndicator extends StatelessWidget {
  final double bmi;
  final String category;
  final bool isUnder18;

  const BmiIndicator({
    Key? key,
    required this.bmi,
    required this.category,
    required this.isUnder18,
  }) : super(key: key);

  /// Computes a normalized 0.0 - 1.0 position on a scale from BMI 12 to 40.
  double _getNormalizedPosition(double value) {
    const double minBmi = 12.0;
    const double maxBmi = 40.0;
    if (value <= minBmi) return 0.0;
    if (value >= maxBmi) return 1.0;
    return (value - minBmi) / (maxBmi - minBmi);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppTheme.getBmiColor(category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top row: Category Badge & BMI Value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: themeColor.withOpacity(0.4), width: 1),
              ),
              child: Text(
                category.toUpperCase(),
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: themeColor,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'BMI',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Visual Gradient/Zone Bar with Indicator Pointer
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            final pointerPos = _getNormalizedPosition(bmi) * barWidth;
            // Clamp pointer to keep icon inside bounds
            final clampedPointerPos = pointerPos.clamp(12.0, barWidth - 12.0);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Horizontal Multi-zone Bar
                Container(
                  height: 12,
                  margin: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 23,
                          child: const ColoredBox(color: AppTheme.bmiUnderweight),
                        ),
                        Expanded(
                          flex: 23,
                          child: const ColoredBox(color: AppTheme.bmiNormal),
                        ),
                        Expanded(
                          flex: 18,
                          child: const ColoredBox(color: AppTheme.bmiOverweight),
                        ),
                        Expanded(
                          flex: 36,
                          child: const ColoredBox(color: AppTheme.bmiObesity),
                        ),
                      ],
                    ),
                  ),
                ),

                // Indicator Pointer
                Positioned(
                  left: clampedPointerPos - 8.0,
                  top: 0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: themeColor,
                      ),
                      Container(
                        width: 3,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppTheme.textPrimary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 10),

        // Zone Tick Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('12', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
            Text('18.5',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary)),
            Text('25.0',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary)),
            Text('30.0',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary)),
            Text('40+', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          ],
        ),

        const SizedBox(height: 14),

        // Legend row
        Wrap(
          spacing: 12,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: const [
            _ScaleLegendItem(
              color: AppTheme.bmiUnderweight,
              label: 'Underweight (<18.5)',
            ),
            _ScaleLegendItem(
              color: AppTheme.bmiNormal,
              label: 'Normal (18.5–24.9)',
            ),
            _ScaleLegendItem(
              color: AppTheme.bmiOverweight,
              label: 'Overweight (25–29.9)',
            ),
            _ScaleLegendItem(
              color: AppTheme.bmiObesity,
              label: 'Obesity (≥30)',
            ),
          ],
        ),
      ],
    );
  }
}

class _ScaleLegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _ScaleLegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
