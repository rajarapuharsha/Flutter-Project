import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_layout.dart';
import 'calculator_screen.dart';

/// Landing dashboard and introduction screen explaining BMI, BMR, and app features.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _navigateToCalculator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CalculatorScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.monitor_heart_rounded,
                color: AppTheme.primaryBlue, size: 24),
            SizedBox(width: 10),
            Text('Health & Energy Portal'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: () => _navigateToCalculator(context),
              icon: const Icon(Icons.calculate_rounded),
              label: const Text('Open Calculator'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryBlue,
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: ResponsiveBreakpoints.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Banner
                  _buildHeroBanner(context),
                  const SizedBox(height: 32),

                  // Feature Cards
                  const Text(
                    'Evidence-Based Health Calculations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildFeatureGrid(context),
                  const SizedBox(height: 32),

                  // Adult BMI Standard Reference Table
                  const Text(
                    'Adult BMI Categories (WHO Standard)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildBmiReferenceTable(),
                  const SizedBox(height: 32),

                  // Calorie Science Card
                  _buildCalorieScienceCard(),
                  const SizedBox(height: 32),

                  // Bottom Call to Action
                  _buildBottomCta(context),
                  const SizedBox(height: 24),

                  // Disclaimer
                  const Text(
                    'Educational Disclaimer: This tool uses standard mathematical screening formulas (Quetelet Index for BMI and Mifflin–St Jeor for BMR). '
                    'Individual metabolic rate varies with hormonal health, genetics, and lean muscle mass. '
                    'Always discuss personal health decisions with a physician or registered dietitian.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0284C7), Color(0xFF0369A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x200284C7),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'CROSS-PLATFORM HEALTH SUITE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'BMI & CALORIE CALCULATOR',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Understand your BMI and estimated daily energy needs with precision Dart algorithms and responsive design.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFE0F2FE),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () => _navigateToCalculator(context),
            icon: const Icon(Icons.speed_rounded, color: AppTheme.primaryBlue),
            label: const Text(
              'Launch Calculator Now',
              style: TextStyle(
                color: AppTheme.primaryBlueDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryBlueDark,
              minimumSize: const Size(220, 48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      const _FeatureInfo(
        title: 'Body Mass Index (BMI)',
        description:
            'Calculated from weight and height using the Quetelet formula to classify adult screening ranges.',
        icon: Icons.scale_rounded,
        color: AppTheme.primaryBlue,
      ),
      const _FeatureInfo(
        title: 'Mifflin–St Jeor BMR',
        description:
            'Clinically recognized as the most accurate non-clinical formula for estimating Basal Metabolic Rate.',
        icon: Icons.bolt_rounded,
        color: AppTheme.secondaryGreen,
      ),
      const _FeatureInfo(
        title: 'Total Energy (TDEE)',
        description:
            'Applies evidence-based multipliers (1.2 to 1.9) according to your lifestyle and exercise cadence.',
        icon: Icons.directions_run_rounded,
        color: AppTheme.bmiPediatric,
      ),
      const _FeatureInfo(
        title: 'Pediatric & Safety Checks',
        description:
            'Detects ages under 18 and special conditions, delivering safe, non-restrictive guidance.',
        icon: Icons.verified_user_rounded,
        color: AppTheme.bmiOverweight,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 130,
          ),
          itemBuilder: (context, index) {
            final f = features[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: f.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(f.icon, color: f.color, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            f.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            f.description,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppTheme.textSecondary,
                              height: 1.35,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBmiReferenceTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: const [
            _ReferenceRow(
              category: 'Underweight',
              range: 'BMI < 18.5',
              summary: 'Nutrient-dense nutrition advised',
              color: AppTheme.bmiUnderweight,
            ),
            Divider(color: AppTheme.borderLight),
            _ReferenceRow(
              category: 'Normal weight',
              range: 'BMI 18.5 – 24.9',
              summary: 'Lowest statistical health risk range',
              color: AppTheme.bmiNormal,
            ),
            Divider(color: AppTheme.borderLight),
            _ReferenceRow(
              category: 'Overweight',
              range: 'BMI 25.0 – 29.9',
              summary: 'Sustainable active habits encouraged',
              color: AppTheme.bmiOverweight,
            ),
            Divider(color: AppTheme.borderLight),
            _ReferenceRow(
              category: 'Obesity',
              range: 'BMI ≥ 30.0',
              summary: 'Consult healthcare professional',
              color: AppTheme.bmiObesity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieScienceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.science_outlined,
                    color: AppTheme.primaryBlue, size: 22),
                SizedBox(width: 8),
                Text(
                  'The Mifflin–St Jeor Scientific Equation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              '• For Males: BMR = (10 × weight in kg) + (6.25 × height in cm) - (5 × age) + 5\n'
              '• For Females: BMR = (10 × weight in kg) + (6.25 × height in cm) - (5 × age) - 161\n\n'
              'Basal Metabolic Rate accounts for approximately 60-75% of daily energy expenditure, '
              'with the remaining balance determined by digestion (thermic effect of food) and activity level multipliers (1.20 to 1.90).',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.secondaryGreenLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryGreen.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppTheme.secondaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ready to calculate your metrics?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Takes under 30 seconds to get your complete health breakdown.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _navigateToCalculator(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryGreen,
              foregroundColor: Colors.white,
              minimumSize: const Size(140, 44),
            ),
            child: const Text('Start Now'),
          ),
        ],
      ),
    );
  }
}

class _FeatureInfo {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _FeatureInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _ReferenceRow extends StatelessWidget {
  final String category;
  final String range;
  final String summary;
  final Color color;

  const _ReferenceRow({
    required this.category,
    required this.range,
    required this.summary,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              range,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              summary,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textMuted,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
