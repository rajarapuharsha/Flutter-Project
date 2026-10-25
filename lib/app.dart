import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// Root application widget configuring MaterialApp, theme modes,
/// and tab-based navigation across the dashboard and calculator views.
class BmiCalorieApp extends StatefulWidget {
  const BmiCalorieApp({super.key});

  @override
  State<BmiCalorieApp> createState() => _BmiCalorieAppState();
}

class _BmiCalorieAppState extends State<BmiCalorieApp> {
  int _currentIndex = 0;

  void _navigateToCalculator() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.health_and_safety, color: AppTheme.primaryNavy),
              SizedBox(width: 10),
              Text(
                'About This Project',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'BMI & Daily Calorie Calculator',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Healthy Living for Sustainable Development',
                  style: TextStyle(fontSize: 13, color: AppTheme.secondaryTeal, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This application is an academic Flutter project developed to promote UN Sustainable '
                  'Development Goal 3 (Good Health and Well-Being). It provides offline calculations for '
                  'BMI, BMR (Mifflin-St Jeor), and Daily Maintenance Calories (TDEE).',
                  style: TextStyle(fontSize: 13, height: 1.45, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Key Standards Implemented:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                const Text(
                  '• WHO Body Mass Index classification ranges\n'
                  '• Mifflin-St Jeor BMR estimation equations\n'
                  '• Harris-Benedict physical activity multipliers (1.2 to 1.9)\n'
                  '• Pediatric safety and non-diagnostic disclaimers',
                  style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF475569)),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Text(
                    'Notice: This application is for educational purposes only and does not provide medical diagnoses or treatment plans.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF92400E), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI & Daily Calorie Calculator — SDG 3',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, size: 20, color: Color(0xFF38BDF8)),
              ),
              const SizedBox(width: 10),
              const Flexible(
                child: Text(
                  'BMI & Calorie Calculator',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Project & SDG Information',
              onPressed: () => _showAboutDialog(context),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(onNavigateToCalculator: _navigateToCalculator),
            const CalculatorScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard, color: AppTheme.primaryNavy),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate_outlined),
              selectedIcon: Icon(Icons.calculate, color: AppTheme.primaryNavy),
              label: 'Calculator',
            ),
          ],
        ),
      ),
    );
  }
}
