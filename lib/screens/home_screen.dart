import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_layout.dart';

/// Main Dashboard screen introducing the application, explaining BMI and caloric
/// metrics, highlighting UN SDG 3 alignment, and providing direct navigation entry points.
class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToCalculator;

  const HomeScreen({
    super.key,
    required this.onNavigateToCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Banner & Title
              _buildHeroHeader(context),
              const SizedBox(height: 24),

              // Quick Action Entry Points
              _buildActionCards(context),
              const SizedBox(height: 28),

              // Educational Primer: BMI & Calories Explained
              _buildPrimerSection(context),
              const SizedBox(height: 28),

              // UN Sustainable Development Goal 3 Feature Card
              _buildSdgSection(context),
              const SizedBox(height: 28),

              // Health Disclaimer Card
              _buildDisclaimerCard(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryNavy, Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI & Daily Calorie Calculator',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Healthy Living for Sustainable Development — UN SDG 3',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF93C5FD),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Understand your body measurements, estimate basal metabolic rate and daily maintenance '
            'energy, and gain insights into balanced nutrition and sustainable lifestyle habits — completely offline '
            'with zero data tracking.',
            style: TextStyle(
              color: Color(0xFFF1F5F9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onNavigateToCalculator,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryTeal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text(
              'Launch Calculator',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final cards = [
      _buildFeatureCard(
        context: context,
        icon: Icons.scale_outlined,
        accentColor: AppTheme.primaryBlue,
        title: 'Body Mass Index (BMI)',
        description:
            'Evaluate weight-to-height ratio classified across Underweight, Normal, Overweight, and Obesity ranges.',
        buttonLabel: 'Calculate BMI',
        onTap: onNavigateToCalculator,
      ),
      _buildFeatureCard(
        context: context,
        icon: Icons.local_fire_department_outlined,
        accentColor: AppTheme.secondaryTeal,
        title: 'Calorie & BMR Estimator',
        description:
            'Compute basal metabolic rate with Mifflin-St Jeor and evaluate maintenance calories using 5 physical activity tiers.',
        buttonLabel: 'Estimate Calories',
        onTap: onNavigateToCalculator,
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: cards[0]),
          const SizedBox(width: 16),
          Expanded(child: cards[1]),
        ],
      );
    } else {
      return Column(
        children: [
          cards[0],
          const SizedBox(height: 14),
          cards[1],
        ],
      );
    }
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required Color accentColor,
    required String title,
    required String description,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accentColor, size: 28),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(42),
                foregroundColor: accentColor,
                side: BorderSide(color: accentColor.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonLabel),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimerSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book_outlined, color: AppTheme.primaryNavy, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Quick Health Primer: BMI & Calories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildPrimerItem(
              title: 'What is Body Mass Index (BMI)?',
              body:
                  'BMI is an epidemiological screening tool representing weight in kilograms divided by height in meters squared (kg/m²). '
                  'While useful for population-level trends, it does not directly differentiate between muscle mass, bone density, and adipose tissue.',
            ),
            const Divider(height: 24),
            _buildPrimerItem(
              title: 'What is Basal Metabolic Rate (BMR)?',
              body:
                  'BMR represents the baseline number of calories your body requires to maintain involuntary vital functions '
                  '(breathing, circulation, cellular repair) in a post-absorptive, resting state. This application uses the validated '
                  'Mifflin-St Jeor equation.',
            ),
            const Divider(height: 24),
            _buildPrimerItem(
              title: 'What is Total Daily Energy Expenditure (TDEE)?',
              body:
                  'TDEE scales your BMR by your physical activity level. Understanding your maintenance energy intake empowers informed '
                  'lifestyle adjustments, balanced nutritional choices, and sustainable health habits.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimerItem({required String title, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF475569),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildSdgSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryTeal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.public, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UN Sustainable Development Goal 3',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF065F46),
                      ),
                    ),
                    Text(
                      'Ensure healthy lives and promote well-being for all at all ages',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'This project contributes to SDG Target 3.4 by promoting preventive wellness, non-communicable disease awareness, '
            'and nutritional education. By providing transparent, privacy-first access to personal health metrics, users are '
            'empowered to build sustainable physical activity habits and engage in informed dialogues with healthcare practitioners.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF064E3B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, color: AppTheme.overweightColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Educational & Non-Diagnostic Disclaimer',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This application is an academic software demonstration intended solely for educational and self-awareness purposes. '
                  'Calculations and classifications are mathematical estimates, not diagnostic medical determinations or personalized nutritional '
                  'prescriptions. Always consult qualified healthcare professionals, registered dietitians, or physicians for personalized medical advice.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade900,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
