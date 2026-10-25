import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// An accessible, visual BMI range spectrum indicator showing category segments,
/// boundary markers, and a dynamic pointer reflecting calculated BMI.
class BmiIndicator extends StatelessWidget {
  final double bmi;
  final String category;
  final bool isPediatric;

  const BmiIndicator({
    super.key,
    required this.bmi,
    required this.category,
    this.isPediatric = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isPediatric) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.underweightColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.underweightColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: AppTheme.underweightColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pediatric Profile: Standard adult BMI scale does not apply to individuals under 18 years. '
                'BMI-for-age percentiles must be used.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.underweightColor,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    // Gauge continuum mapping: 12.0 to 40.0 BMI
    const minScale = 12.0;
    const maxScale = 40.0;
    final normalizedPosition = ((bmi - minScale) / (maxScale - minScale)).clamp(0.0, 1.0);
    final activeColor = AppTheme.getColorForCategory(category);

    return Semantics(
      label: 'BMI Category Bar: Current BMI is ${bmi.toStringAsFixed(1)}, classified as $category.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI Range Spectrum',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: activeColor),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: activeColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Pointer Marker
          LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              final pointerX = (trackWidth * normalizedPosition).clamp(8.0, trackWidth - 8.0);

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Segmented Color Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 14,
                      child: Row(
                        children: [
                          // Underweight (< 18.5): 12.0 to 18.5 is 6.5 units out of 28 total (23.2%)
                          const Expanded(
                            flex: 65,
                            child: ColoredBox(color: AppTheme.underweightColor),
                          ),
                          const SizedBox(width: 2),
                          // Normal weight (18.5 to 25.0): 6.5 units out of 28 total (23.2%)
                          const Expanded(
                            flex: 65,
                            child: ColoredBox(color: AppTheme.normalWeightColor),
                          ),
                          const SizedBox(width: 2),
                          // Overweight (25.0 to 30.0): 5.0 units out of 28 total (17.9%)
                          const Expanded(
                            flex: 50,
                            child: ColoredBox(color: AppTheme.overweightColor),
                          ),
                          const SizedBox(width: 2),
                          // Obesity (>= 30.0): 10.0 units out of 28 total (35.7%)
                          const Expanded(
                            flex: 100,
                            child: ColoredBox(color: AppTheme.obesityColor),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Indicator Pointer Needle
                  Positioned(
                    left: pointerX - 6,
                    top: -6,
                    child: Column(
                      children: [
                        Container(
                          width: 12,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF0F172A), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
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

          // Scale Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRangeLabel(context, '<18.5\nUnder', AppTheme.underweightColor),
              _buildRangeLabel(context, '18.5-24.9\nNormal', AppTheme.normalWeightColor),
              _buildRangeLabel(context, '25-29.9\nOver', AppTheme.overweightColor),
              _buildRangeLabel(context, '≥30\nObese', AppTheme.obesityColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRangeLabel(BuildContext context, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                height: 1.1,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
        ),
      ],
    );
  }
}
