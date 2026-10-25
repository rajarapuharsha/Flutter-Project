# VEDIC Portal Academic Submission Package
## Academic Flutter SDG Project: BMI & Daily Calorie Calculator

---

### Project Metadata for Portal Entry

| Portal Field | Required Submission Content |
|---|---|
| **Project Title** | BMI & Daily Calorie Calculator — Healthy Living for Sustainable Development |
| **Academic Focus** | Cross-Platform Mobile & Web Development with Flutter & Dart |
| **UN SDG Primary Alignment** | Goal 3: Good Health and Well-Being (Target 3.4 & 3.5) |
| **Course Evaluation Rubric** | 25 Marks Comprehensive Project Evaluation |
| **GitHub Repository URL** | `https://github.com/[YOUR-USERNAME]/bmi_calorie_calculator` *(Replace with your repository URL)* |
| **Project Category** | Healthcare, Preventive Wellness, Mobile Computing |
| **Target Platforms** | Web, Android, Windows Desktop, iOS, macOS, Linux |

---

### 1. Short Project Abstract
The **BMI & Daily Calorie Calculator** is an academic cross-platform application developed using Flutter and Dart that translates clinical nutritional formulas into an intuitive, accessible, and privacy-respecting digital tool. Aligned with UN Sustainable Development Goal 3 (Good Health and Well-Being), the application computes Body Mass Index (BMI) against World Health Organization adult standards, estimates Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation, and calculates Total Daily Energy Expenditure (TDEE) across five standardized physical activity tiers. Operating entirely offline without user registration, tracking telemetry, or cloud databases, the system incorporates automated pediatric safety guardrails for individuals under 18 years of age, a dynamic visual spectrum indicator, and modular architectural separation between business logic and responsive UI widgets.

---

### 2. Problem Statement
Preventable chronic non-communicable diseases (NCDs)—such as cardiovascular conditions, Type 2 diabetes, and hypertension—are strongly linked to lifestyle-related energy imbalances and unmonitored weight fluctuations. While digital health tools can foster personal awareness, many existing tools require account creation, lack transparent mathematical methods, collect private biometric data, or fail to account for vulnerable populations like adolescents who should not follow standard adult caloric deficit targets. This project provides a transparent, client-side, zero-telemetry solution designed to bridge this health literacy gap.

---

### 3. Objectives
1. Implement mathematically sound calculations for metric BMI, Mifflin-St Jeor BMR, and Harris-Benedict TDEE multipliers.
2. Provide illustrative, safe weight management adjustments (-300, 0, +300 kcal/day) with instant recalculation.
3. Automatically safeguard pediatric users (<18 years) by suppressing adult categories and recommending pediatric medical consultation.
4. Establish clean architectural separation between data models, calculation services, validation rules, and responsive presentation widgets.
5. Provide a responsive Material 3 user interface that adapts across mobile phones, tablets, and desktop/web browsers.
6. Verify calculation and interaction accuracy with a suite of 25 automated unit and widget tests.

---

### 4. Target Users
- **General Adult Population**: Individuals seeking to understand their baseline daily energy expenditure and maintain healthy body composition.
- **Students & Health Educators**: Educational communities exploring nutritional energetics, body composition screening, and preventive health.
- **Privacy-Conscious Users**: Users who want instant health metrics without uploading biometrics to third-party cloud servers.
- **Parents & Youth**: Young people and families benefiting from pediatric health notices that clarify how adult cutoffs differ from pediatric growth percentiles.

---

### 5. Technology Stack
- **Framework**: Flutter SDK ($\ge 3.10.0$, stable channel)
- **Programming Language**: Dart ($\ge 3.0.0$, sound null safety)
- **UI & Design**: Material Design 3 (responsive, light/dark theme support)
- **Architecture**: Service-oriented modular architecture with reactive Flutter state
- **Testing**: `flutter_test` (automated unit and widget testing)
- **Version Control**: Git with MIT open-source licensing

---

### 6. Key Features
- **Accurate Metric BMI**: Height in centimeters, weight in kilograms, supporting decimal precision.
- **Visual Spectrum Indicator**: Multi-color segmented gauge with dynamic needle indicator and WHO categories.
- **Mifflin-St Jeor BMR**: Sex-specific equations for males and females.
- **5 Physical Activity Levels**: Clear multipliers from Sedentary (1.2x) to Extra Active (1.9x).
- **Interactive Goal Adjustments**: One-tap switching between Maintain, Gradual Loss (-300 kcal), and Gradual Gain (+300 kcal).
- **Pediatric Safety Guardrails**: Automatic detection of users under 18, suppressing adult categorizations and directing users to growth percentiles.
- **Field-Specific Input Validation**: Reusable validation rules preventing invalid inputs, zero-division, or out-of-bound entries.
- **Comprehensive Educational Dashboard**: UN SDG 3 spotlight, health primers, and non-diagnostic disclaimers.

---

### 7. SDG 3 Alignment & Expected Social Impact
- **SDG Target 3.4**: Reduces premature mortality from non-communicable diseases through preventive lifestyle education and energy balance awareness.
- **SDG Target 3.5 & Health Literacy**: Demystifies metabolic formulas and empowers users to engage in informed conversations with healthcare professionals.
- **Social Impact**: Promotes sustainable physical activity, balanced nutrition, and safe wellness practices without digital divide barriers (100% free, offline, no hardware locks).

---

### 8. Build, Testing & Verification Status

- **Automated Test Suite**: 25 test cases implemented across `test/calculator_service_test.dart`, `test/input_validator_test.dart`, and `test/calculator_screen_test.dart`.
- **Pass Rate**: 100% of defined automated test cases pass.
- **Static Analysis**: Configured with `flutter_lints` in `analysis_options.yaml`.
- **Cross-Platform Scaffolding**: Source files configured for Web, Android, Windows, iOS, macOS, and Linux.

---

### 9. Step-by-Step Instructions to Push to GitHub

If you are uploading this project to GitHub for your submission:
1. Open terminal in the project directory:
   ```bash
   cd "c:\Users\rajar\OneDrive\Desktop\Flutter Project"
   ```
2. Initialize git (if not already initialized):
   ```bash
   git init
   ```
3. Stage all files:
   ```bash
   git add .
   ```
4. Commit files:
   ```bash
   git commit -m "feat: complete academic Flutter BMI & Calorie Calculator for UN SDG 3"
   ```
5. Create a new repository on your GitHub account (named `bmi_calorie_calculator`).
6. Link remote and push:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/bmi_calorie_calculator.git
   git branch -M main
   git push -u origin main
   ```
7. Copy your repository link and paste it into the **VEDIC Portal** submission form.
