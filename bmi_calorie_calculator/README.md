# BMI & Calorie Calculator

A modern, responsive, cross-platform Flutter application designed to calculate **Body Mass Index (BMI)**, estimate **Daily Basal Metabolic Rate (BMR)** and **Maintenance Calorie Requirements (TDEE)**, classify adult BMI categories according to WHO standards, and provide personalized health advice.

Built with Flutter and Dart, supporting **Android, iOS, Web, Windows, macOS, and Linux** from a single shared codebase.

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Formulas and Scientific Methodology](#formulas-and-scientific-methodology)
  - [1. Body Mass Index (BMI)](#1-body-mass-index-bmi)
  - [2. Adult BMI Classifications](#2-adult-bmi-classifications)
  - [3. Mifflin–St Jeor BMR Equation](#3-mifflinst-jeor-bmr-equation)
  - [4. Total Daily Energy Expenditure (TDEE)](#4-total-daily-energy-expenditure-tdee)
  - [5. Calorie Goal Adjustments](#5-calorie-goal-adjustments)
- [Pediatric and Clinical Safety Logic](#pediatric-and-clinical-safety-logic)
- [Project Architecture and File Responsibilities](#project-architecture-and-file-responsibilities)
- [Responsive Design Strategy](#responsive-design-strategy)
- [Getting Started and Local Setup](#getting-started-and-local-setup)
- [Running the Application](#running-the-application)
- [Building Release Binaries for All Platforms](#building-release-binaries-for-all-platforms)
- [Unit Testing](#unit-testing)
- [Platform Environment Report](#platform-environment-report)

---

## Overview

- **Application Name**: BMI & Calorie Calculator
- **Framework**: Flutter 3.24+ / Dart 3.5+
- **Design System**: Google Material Design 3 (accessible light theme, emerald & sky accents)
- **State Management**: Clean Flutter StatefulWidget architecture with immutable calculation service models
- **Offline Capable**: 100% offline; zero backend dependencies, logins, or tracking

---

## Key Features

1. **Dual Metric Calculation**: Simultaneously calculates BMI and daily energy expenditure in one simple workflow.
2. **Interactive BMI Gauge**: Colored horizontal scale with dynamic pointer indicating whether the user is Underweight, Normal weight, Overweight, or within Obesity ranges.
3. **Mifflin–St Jeor Metabolic Accuracy**: Uses the gold-standard non-clinical formula to compute Basal Metabolic Rate (BMR).
4. **Activity Multiplier Adjustment**: 5 distinct lifestyle tiers (Sedentary, Lightly Active, Moderately Active, Very Active, Extra Active).
5. **Goal-Based Calorie Targets**:
   - Maintain weight (matches TDEE)
   - Gradual weight loss (mild deficit of -300 kcal/day)
   - Gradual weight gain (mild surplus of +300 kcal/day)
6. **Safety First**:
   - Explicit pediatric detection for ages under 18 (redirects to pediatrician advice).
   - Dedicated toggle for pregnancy, breastfeeding, or clinical conditions.
   - Comprehensive screening disclaimers.
7. **Adaptive Multi-Platform Layout**:
   - Mobile: Vertical single-column scroll with smooth navigation.
   - Tablet: Wide cards with comfortable touch targets.
   - Desktop & Web: Side-by-side 2-column layout (Inputs on the left, Real-time Results on the right).

---

## Formulas and Scientific Methodology

### 1. Body Mass Index (BMI)

Body Mass Index is calculated using the Quetelet formula:

$$\text{BMI} = \frac{\text{Weight (kg)}}{[\text{Height (m)}]^2} = \frac{\text{Weight (kg)}}{(\text{Height (cm)} / 100)^2}$$

Dart implementation (`lib/services/calculator_service.dart`):

```dart
double calculateBMI(double weightKg, double heightCm) {
  final heightM = heightCm / 100.0;
  return weightKg / (heightM * heightM);
}
```

### 2. Adult BMI Classifications

Adult BMI categories follow standard World Health Organization (WHO) boundaries:

| Category | BMI Range ($kg/m^2$) | Clinical Perspective |
|---|---|---|
| **Underweight** | $< 18.5$ | Focus on nutrient-dense meals and consult a physician. |
| **Normal weight** | $18.5 - 24.9$ | Associated with lowest statistical chronic disease risk. |
| **Overweight** | $25.0 - 29.9$ | Sustainable lifestyle habits and regular physical exercise encouraged. |
| **Obesity** | $\ge 30.0$ | Medical evaluation recommended for individualized wellness. |

### 3. Mifflin–St Jeor BMR Equation

Basal Metabolic Rate is the baseline energy expenditure required to sustain vital organ functions at rest:

- **For Adult Males**:
  $$\text{BMR} = (10 \times \text{weightKg}) + (6.25 \times \text{heightCm}) - (5 \times \text{age}) + 5$$

- **For Adult Females**:
  $$\text{BMR} = (10 \times \text{weightKg}) + (6.25 \times \text{heightCm}) - (5 \times \text{age}) - 161$$

### 4. Total Daily Energy Expenditure (TDEE)

Maintenance calories are calculated by multiplying BMR by the chosen physical activity level multiplier:

$$\text{TDEE} = \text{BMR} \times \text{Activity Multiplier}$$

| Activity Level | Multiplier | Description |
|---|:---:|---|
| **Sedentary** | `1.200` | Little or no structured exercise, desk job |
| **Lightly active** | `1.375` | Light physical activity or exercise 1–3 days/week |
| **Moderately active** | `1.550` | Moderate aerobic or resistance exercise 3–5 days/week |
| **Very active** | `1.725` | Strenuous exercise or physical training 6–7 days/week |
| **Extra active** | `1.900` | Heavy daily physical labor or two-a-day intense training |

### 5. Calorie Goal Adjustments

To maintain safety and prevent extreme deficits, the app provides gentle, evidence-based adjustments:

- **Maintain Weight**: $\text{Target} = \text{TDEE}$
- **Gradual Weight Loss**: $\text{Target} = \text{TDEE} - 300\text{ kcal/day}$
- **Gradual Weight Gain**: $\text{Target} = \text{TDEE} + 300\text{ kcal/day}$

*Note: Calorie targets are clamped to a minimum floor of 1,000 kcal to prevent dangerous low-calorie estimates.*

---

## Pediatric and Clinical Safety Logic

- **Under 18 Years Old**: Adult BMI categories and generic calorie deficits do not apply to developing bodies. For users under 18, the app replaces adult BMI classifications with a pediatric notice emphasizing the need for age-and-sex-adjusted growth percentiles evaluated by a pediatrician.
- **Special Populations**: A dedicated toggle addresses pregnancy, nursing, or clinical conditions, ensuring users receive clear guidance to consult their primary healthcare team rather than using generic formulas.

---

## Project Architecture and File Responsibilities

The codebase strictly isolates responsibilities across modular layers:

```text
bmi_calorie_calculator/
│
├── android/                             # Android native runner configuration
├── ios/                                 # iOS Xcode runner configuration
├── web/                                 # Web entrypoint and manifest
├── windows/                             # Windows Win32 runner and CMake configuration
├── macos/                               # macOS Cocoa runner and Xcode project
├── linux/                               # Linux GTK/Flutter runner configuration
│
├── lib/
│   ├── main.dart                        # Application bootstrap (runApp)
│   ├── app.dart                         # MaterialApp declaration and root theme binding
│   │
│   ├── models/
│   │   └── calculator_result.dart       # Enums (Gender, ActivityLevel, CalorieGoal) and immutable result model
│   │
│   ├── services/
│   │   └── calculator_service.dart      # Pure Dart calculation functions, Mifflin-St Jeor math, and advice conditionals
│   │
│   ├── utils/
│   │   └── input_validator.dart         # Form validation rules (bounds, zero prevention, type safety)
│   │
│   ├── screens/
│   │   ├── home_screen.dart             # Landing dashboard, feature highlights, and scientific reference charts
│   │   └── calculator_screen.dart       # Interactive calculation screen and UI state management
│   │
│   ├── widgets/
│   │   ├── input_form.dart              # User form (controllers, radios, dropdowns, calculate/reset buttons)
│   │   ├── result_card.dart             # Card displaying calculated BMI, BMR, TDEE, and personalized advice
│   │   ├── bmi_indicator.dart           # Custom colored horizontal gauge showing BMI zone and pointer
│   │   ├── activity_level_selector.dart # Interactive selector cards for the 5 activity tiers
│   │   └── responsive_layout.dart       # Adaptive layout builder (mobile, tablet, desktop)
│   │
│   └── theme/
│       └── app_theme.dart               # Palette, typography, card borders, and theme definitions
│
├── test/
│   ├── calculator_service_test.dart     # Comprehensive unit tests for all math and boundary conditionals
│   └── input_validator_test.dart        # Unit tests covering boundary, type, and empty-input validation
│
├── pubspec.yaml                         # Project dependencies and Flutter asset configuration
├── analysis_options.yaml                # Static analysis and linting configuration
├── README.md                            # Complete setup, architectural, and operational documentation
└── .gitignore                           # Standard Flutter and platform build ignore file
```

---

## Responsive Design Strategy

The app utilizes `ResponsiveLayout` with three distinct breakpoints:

1. **Mobile (< 700 px)**:
   - Single-column vertical scroll flow.
   - Large, finger-friendly touch targets.
   - Smooth auto-scroll to results upon calculation.
2. **Tablet (700 px - 1050 px)**:
   - Contained card views with maximum 1050 px width.
   - Enhanced spacing and comfortable grid alignments.
3. **Desktop & Web ( $\ge$ 1050 px)**:
   - Centered container constrained to 1200 px.
   - Two-column layout: Form on the left (flex 5), Result card on the right (flex 6).
   - Full keyboard tab navigation and focus traversal.

---

## Getting Started and Local Setup

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.24.0 or newer)
- [Dart SDK](https://dart.dev/get-dart) (version 3.5.0 or newer)
- VS Code (with Flutter extension) or Android Studio

### Installation

1. Navigate to the project folder:
   ```bash
   cd bmi_calorie_calculator
   ```

2. Download all dependencies:
   ```bash
   flutter pub get
   ```

3. Verify Flutter environment health:
   ```bash
   flutter doctor
   ```

---

## Running the Application

### Web Browser
```bash
flutter run -d chrome
# or with Edge:
flutter run -d edge
```

### Windows Desktop
```bash
flutter run -d windows
```

### Android Emulator or Physical Device
```bash
flutter run -d android
```

### macOS Desktop
```bash
flutter run -d macos
```

### Linux Desktop
```bash
flutter run -d linux
```

---

## Building Release Binaries for All Platforms

### 1. Web
```bash
flutter build web --release
```
*Output: `build/web/` ready to deploy to GitHub Pages, Firebase Hosting, or any static host.*

### 2. Android APK / App Bundle
```bash
# Standalone APK:
flutter build apk --release

# Google Play Bundle:
flutter build appbundle --release
```
*Requirements: Android SDK and Java Development Kit (JDK 17).*

### 3. Windows Desktop
```bash
flutter build windows --release
```
*Requirements: Windows 10/11 with Visual Studio 2022 ("Desktop development with C++" workload).*

### 4. iOS
```bash
flutter build ios --release
```
*Requirements: macOS computer with Xcode and CocoaPods installed.*

### 5. macOS Desktop
```bash
flutter build macos --release
```
*Requirements: macOS computer with Xcode installed.*

### 6. Linux Desktop
```bash
flutter build linux --release
```
*Requirements: Linux OS with `clang`, `cmake`, `ninja-build`, `pkg-config`, and `libgtk-3-dev` installed.*

---

## Unit Testing

Run the automated test suite to verify math formulas, boundary conditions, and validation:

```bash
flutter test
```

### Test Coverage Highlights:
- **BMI Calculation**: Verifies standard inputs, zero prevention, negative value handling, and boundary points (18.4, 18.5, 24.9, 25.0, 29.9, 30.0).
- **Mifflin–St Jeor BMR**: Validates male and female baseline equations against clinical benchmark figures.
- **Activity Multipliers**: Asserts precision for all 5 tiers (1.2 to 1.9).
- **Calorie Goals**: Tests maintenance, mild deficit (-300), and mild surplus (+300).
- **Form Validator**: Rejects empty strings, decimals in integer age, non-numbers, out-of-range values, and zero height.

---

## Platform Environment Report

| Platform | Codebase Support | Build Requirements | Current Host Status |
|---|:---:|---|---|
| **Web** | Ready | Modern Web Browser (Chrome / Edge / Firefox / Safari) | Not verified on this computer |
| **Windows** | Ready | Visual Studio 2022 C++ Desktop workload | Not verified on this computer |
| **Android** | Ready | Android Studio & Android SDK Command-line Tools | Not verified on this computer |
| **iOS** | Ready | Apple macOS with Xcode 15+ & CocoaPods | Requires macOS host |
| **macOS** | Ready | Apple macOS with Xcode 15+ | Requires macOS host |
| **Linux** | Ready | Linux with GTK 3 development headers | Requires Linux host |

All 6 platform runner directories are configured and ready for compilation in their respective target environments.

---

## Evaluation Rubric and Submission Checklist

This section maps the project to the 25-mark Flutter SDG evaluation rubric and can be used when preparing the hard-copy report and portal submission.

| Rubric area | Marks | Evidence in this project |
|---|---:|---|
| UI/UX Design | 5 | Material 3 theme, responsive home and calculator screens, clear input validation, BMI indicator, and accessible result cards. |
| Functionality and Features | 7 | BMI, Mifflin–St Jeor BMR, activity-adjusted maintenance estimates, optional adult goal estimate, reset, and safety guidance. |
| Flutter Coding and Implementation | 5 | Shared Flutter app with separate screens, widgets, model, service, validation, and tests. |
| SDG Relevance and Social Impact | 3 | Supports SDG 3 (Good Health and Well-being) through accessible health education and non-diagnostic estimates. |
| GitHub Code Submission and VEDIC Portal Link | 2 | Submit the repository URL and VEDIC entry URL below after publishing the project. |
| Project Documentation (Hard Copy and Soft Copy) | 3 | This README documents purpose, formulas, structure, setup, operation, tests, and platform requirements; print or export it for the hard copy. |

### Submission details to complete

- **GitHub repository:** `[Paste the public or evaluator-accessible repository URL here]`
- **VEDIC portal project entry:** `[Paste the submitted project URL here]`
- **Student name / roll number / class:** `[Complete before printing or submission]`
- **Demonstration platform and date:** `[Complete after the live demonstration]`

### Demonstration flow

1. Open the app and explain its SDG 3 health education purpose and screening disclaimer.
2. Enter age, gender, height, weight, activity level, and a calorie goal; calculate and explain BMI, BMR, maintenance calories, and the BMI category.
3. Change inputs and calculate again, then use Reset to show the form and result clear correctly.
4. Demonstrate an under-18 or special-population case and point out that adult goal-based calorie targets are withheld.
5. Show the modular source folders and run `flutter analyze` and `flutter test` on the presentation computer if Flutter is installed.

### Social impact statement

This project supports **United Nations Sustainable Development Goal 3: Good Health and Well-being** by making basic BMI and energy-estimate concepts easy to explore on common devices. It is an educational tool: BMI is a screening measure, calorie estimates are approximate, and users should consult qualified health professionals for personal decisions.
