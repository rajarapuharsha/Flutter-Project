# BMI & Daily Calorie Calculator — Healthy Living for Sustainable Development

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![SDG 3](https://img.shields.io/badge/UN%20SDG-3%20Good%20Health-4C9F38)](https://sdgs.un.org/goals/goal3)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An academic, production-quality cross-platform Flutter application engineered for **UN Sustainable Development Goal 3: Good Health and Well-Being**. The application provides offline, privacy-first calculations for Body Mass Index (BMI), Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation, and Total Daily Energy Expenditure (TDEE) based on five physical activity levels.

---

## Table of Contents
- [Key Features](#key-features)
- [UN SDG 3 Alignment](#un-sdg-3-alignment)
- [Scientific Formulas & Logic](#scientific-formulas--logic)
- [Project Architecture](#project-architecture)
- [Getting Started](#getting-started)
- [Running Automated Tests](#running-automated-tests)
- [Cross-Platform Build Commands](#cross-platform-build-commands)
- [VEDIC Portal & Academic Submission](#vedic-portal--academic-submission)
- [Privacy & Security](#privacy--security)
- [Documentation Deliverables](#documentation-deliverables)
- [License](#license)

---

## Key Features

1. **Body Mass Index (BMI) Engine**:
   - Calculates metric BMI ($\text{kg/m}^2$) from height and weight with decimal support.
   - Evaluates adult WHO categories: Underweight ($<18.5$), Normal ($18.5 - 24.9$), Overweight ($25.0 - 29.9$), Obesity ($\ge 30.0$).
   - Dynamic, accessible visual spectrum gauge with needle indicator and category color badges.
2. **Basal Metabolic Rate (BMR) Estimator**:
   - Evaluates resting baseline calorie expenditure using the clinically validated Mifflin-St Jeor formula (Male and Female physiological constants).
3. **Daily Maintenance Calories (TDEE)**:
   - Scales BMR across 5 physical activity tiers: Sedentary (1.2x), Lightly Active (1.375x), Moderately Active (1.55x), Very Active (1.725x), and Extra Active (1.9x).
4. **Illustrative Caloric Adjustments**:
   - Offers optional targets for Weight Maintenance, Gradual Weight Loss (-300 kcal/day), and Gradual Weight Gain (+300 kcal/day).
   - Recalculates dynamically when tapping chips without re-entering form data.
5. **Pediatric Safety Guardrails**:
   - Detects users under 18 years of age.
   - Suppresses adult BMI categories and weight management targets.
   - Displays age-appropriate guidance advising consultation with pediatric healthcare providers.
6. **Responsive Material 3 Design**:
   - Dynamic reflow: Single-column scrollable layout on mobile; two-column split layout on desktop and web.
   - Light and Dark mode support with accessible contrast ratios.
7. **100% Offline & Privacy-First**:
   - Zero remote servers, cloud databases, user registration, or tracking analytics.

---

## UN SDG 3 Alignment

Aligned with **United Nations Sustainable Development Goal 3: Good Health and Well-Being**:
- **Target 3.4**: Non-communicable disease awareness through preventive self-care, healthy energy balance awareness, and active lifestyle promotion.
- **Target 3.5 & Health Literacy**: Transparently explains the scientific meaning of BMI, BMR, and TDEE, demystifying health metrics for users.
- **Ethical Disclaimer**: Clearly states that calculations are mathematical estimates intended for educational self-awareness, not medical diagnoses.

---

## Scientific Formulas & Logic

### 1. Body Mass Index (BMI)
$$\text{BMI} = \frac{\text{Weight (kg)}}{\left(\frac{\text{Height (cm)}}{100}\right)^2}$$

### 2. Mifflin-St Jeor BMR Equations
- **Male**: $\text{BMR} = 10 \times \text{Weight (kg)} + 6.25 \times \text{Height (cm)} - 5 \times \text{Age (years)} + 5$
- **Female**: $\text{BMR} = 10 \times \text{Weight (kg)} + 6.25 \times \text{Height (cm)} - 5 \times \text{Age (years)} - 161$

### 3. Total Daily Energy Expenditure (TDEE)
$$\text{TDEE} = \text{BMR} \times \text{Activity Multiplier}$$

---

## Project Architecture

```text
bmi_calorie_calculator/
├── android/                   # Android native configuration
├── ios/                       # iOS configuration
├── web/                       # Web configuration & manifest
├── windows/                   # Windows Desktop configuration
├── macos/                     # macOS configuration
├── linux/                     # Linux configuration
├── lib/
│   ├── main.dart              # Application entry point
│   ├── app.dart               # MaterialApp, theme configuration, navigation
│   ├── models/
│   │   └── calculator_result.dart  # Immutable result model and enums
│   ├── services/
│   │   └── calculator_service.dart # BMI, BMR, TDEE mathematical service
│   ├── utils/
│   │   └── input_validator.dart    # Reusable boundary and input validator
│   ├── screens/
│   │   ├── home_screen.dart        # Main dashboard & SDG 3 educational primer
│   │   └── calculator_screen.dart  # Form state, results, and dynamic switcher
│   ├── widgets/
│   │   ├── input_form.dart         # Reusable form & validation controls
│   │   ├── result_card.dart        # Result card presentation component
│   │   ├── bmi_indicator.dart      # Visual spectrum bar & pointer
│   │   ├── activity_level_selector.dart # Activity tier dropdown
│   │   └── responsive_layout.dart  # Adaptive multi-breakpoint manager
│   └── theme/
│       └── app_theme.dart          # Material 3 light and dark theme definitions
├── test/
│   ├── calculator_service_test.dart# 12 unit tests (BMI, BMR, TDEE, goals)
│   ├── input_validator_test.dart   # 9 unit tests (boundary validation)
│   └── calculator_screen_test.dart # 4 widget tests (UI & interactions)
├── pubspec.yaml               # Project dependencies and metadata
├── analysis_options.yaml      # Static analysis lint rules
├── README.md                  # Project overview and documentation
├── LICENSE                    # MIT open-source license
└── docs/
    ├── project_report.md      # Comprehensive 25-section academic report
    ├── user_manual.md         # Complete user guide and FAQ
    └── testing_report.md      # Detailed test matrix and results
```

---

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) ($\ge 3.10.0$)
- [Dart SDK](https://dart.dev/get-dart) ($\ge 3.0.0$)

### Installation & Execution
1. Clone or open the repository:
   ```bash
   git clone https://github.com/rajarapuharsha/Flutter-Project.git
   cd Flutter-Project
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run on your preferred platform:
   ```bash
   # Run in Web Browser
   flutter run -d chrome

   # Run on Windows Desktop
   flutter run -d windows

   # Run on connected Android device/emulator
   flutter run -d android
   ```

---

## Running Automated Tests

Run the complete test suite:
```bash
flutter test
```

Run static analysis:
```bash
flutter analyze
```

Format code:
```bash
dart format .
```

---

## Cross-Platform Build Commands

Build release packages using Flutter tooling:

```bash
# Web
flutter build web --release

# Android APK
flutter build apk --release

# Windows Desktop
flutter build windows --release

# iOS (requires macOS and Xcode)
flutter build ios --release

# macOS Desktop (requires macOS)
flutter build macos --release

# Linux Desktop (requires Linux with GTK tools)
flutter build linux --release
```

---

## VEDIC Portal & Academic Submission

This project is prepared for submission to the **VEDIC Portal** and academic course evaluation (25-mark rubric):
- **Project Title:** BMI & Daily Calorie Calculator — Healthy Living for Sustainable Development
- **Course Component:** Academic Flutter SDG Project
- **SDG Goal:** SDG 3 (Target 3.4: Good Health and Well-Being)
- **Repository URL:** `https://github.com/rajarapuharsha/Flutter-Project.git`
- **Submission Artifacts:** Full source code, 25-section Project Report (`docs/project_report.md`), User Manual (`docs/user_manual.md`), and Testing Report (`docs/testing_report.md`).

---

## Privacy & Security

- **Zero Cloud Storage**: Measurements are never uploaded, stored in external databases, or shared.
- **Offline By Design**: Operates seamlessly in airplane mode or with network disabled.
- **Session-Only Memory**: Data resides in client memory during runtime and is cleared upon resetting.

---

## Documentation Deliverables

Detailed technical documentation is provided in the `docs/` folder:
- [Comprehensive Academic Project Report](docs/project_report.md)
- [User Manual & FAQ](docs/user_manual.md)
- [Quality Assurance & Testing Report](docs/testing_report.md)

---

## License

This project is licensed under the [MIT License](LICENSE).
