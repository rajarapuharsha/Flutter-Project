# User Manual: BMI & Daily Calorie Calculator
## Healthy Living for Sustainable Development (UN SDG 3)

---

### Table of Contents
1. [Introduction](#1-introduction)
2. [System Requirements & Installation](#2-system-requirements--installation)
3. [Launching the Application](#3-launching-the-application)
4. [Navigating the Dashboard](#4-navigating-the-dashboard)
5. [Step-by-Step Calculator Guide](#5-step-by-step-calculator-guide)
   - [5.1 Entering Personal Profile](#51-entering-personal-profile)
   - [5.2 Entering Body Measurements](#52-entering-body-measurements)
   - [5.3 Selecting Activity Level](#53-selecting-activity-level)
   - [5.4 Selecting Caloric Objective](#54-selecting-caloric-objective)
   - [5.5 Executing Calculation](#55-executing-calculation)
6. [Interpreting Your Results](#6-interpreting-your-results)
   - [6.1 Body Mass Index (BMI) & Visual Spectrum](#61-body-mass-index-bmi--visual-spectrum)
   - [6.2 Basal Metabolic Rate (BMR)](#62-basal-metabolic-rate-bmr)
   - [6.3 Daily Maintenance Calories (TDEE)](#63-daily-maintenance-calories-tdee)
   - [6.4 Weight Objective Caloric Adjustment](#64-weight-objective-caloric-adjustment)
   - [6.5 Pediatric & Adolescent Notice](#65-pediatric--adolescent-notice)
   - [6.6 Lifestyle & Nutrition Recommendations](#66-lifestyle--nutrition-recommendations)
7. [Resetting the Calculator](#7-resetting-the-calculator)
8. [Privacy, Data Security & Offline Use](#8-privacy-data-security--offline-use)
9. [Frequently Asked Questions (FAQ)](#9-frequently-asked-questions-faq)
10. [Health & Safety Disclaimer](#10-health--safety-disclaimer)

---

### 1. Introduction
The **BMI & Daily Calorie Calculator** is an academic software application designed to support **United Nations Sustainable Development Goal 3: Good Health and Well-Being**. The application calculates Body Mass Index (BMI), Basal Metabolic Rate (BMR) via the Mifflin-St Jeor formula, and Total Daily Energy Expenditure (TDEE) across five standard physical activity tiers.

It is 100% offline, privacy-first, and requires no account registration, remote servers, or background analytics.

---

### 2. System Requirements & Installation

| Platform | Minimum OS Version | Hardware Requirements |
|---|---|---|
| **Web** | Modern browser (Chrome 90+, Edge 90+, Firefox 88+, Safari 14+) | 1 GHz CPU, 2 GB RAM, 1024x768 display |
| **Android** | Android 5.0 (API level 21) or higher | 1.5 GHz multi-core, 2 GB RAM |
| **Windows Desktop** | Windows 10 (64-bit) or Windows 11 | x64 CPU, 4 GB RAM, DirectX 11 support |
| **iOS / iPadOS** | iOS 12.0 or higher | 64-bit Apple device |
| **macOS Desktop** | macOS 10.14 (Mojave) or higher | Intel or Apple Silicon, 4 GB RAM |
| **Linux Desktop** | Ubuntu 20.04 LTS+, Fedora 36+, or equivalent | 64-bit x86/ARM, GTK 3.0+ |

---

### 3. Launching the Application

#### Running from Source (Development Environment)
1. Ensure the Flutter SDK is installed on your system.
2. Open a terminal inside the project directory:
   ```bash
   cd "c:\Users\rajar\OneDrive\Desktop\Flutter Project"
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run on your desired platform:
   - **Web Browser (Chrome)**: `flutter run -d chrome`
   - **Windows Desktop**: `flutter run -d windows`
   - **Android Device/Emulator**: `flutter run -d android`
   - **macOS Desktop**: `flutter run -d macos`
   - **Linux Desktop**: `flutter run -d linux`

---

### 4. Navigating the Dashboard
Upon opening the app, you arrive at the **Main Dashboard**:
- **Hero Banner**: Features the project title, SDG 3 mission statement, and a direct "Launch Calculator" button.
- **Feature Cards**: Separate entry points highlighting BMI and Daily Calorie estimation principles.
- **Quick Health Primer**: Concise explanations of BMI, BMR, and TDEE.
- **UN SDG 3 Card**: In-depth description of Target 3.4 (preventive health, lifestyle disease mitigation).
- **Navigation Bar**: Located at the bottom (or side on desktop) allowing instant toggling between `Dashboard` and `Calculator`.
- **Top Bar Info Action**: Tap the info icon (`ℹ️`) in the upper-right corner at any time to open the "About This Project" summary modal.

---

### 5. Step-by-Step Calculator Guide

#### 5.1 Entering Personal Profile
1. **Age**: Enter your current age in completed years (e.g., `25`).
   - Allowed range: `2` to `120` years.
   - *Note*: If age is under 18, pediatric safety guardrails will be activated.
2. **Biological Sex**: Select **Male** or **Female** using the toggle segment.
   - This selection supplies the sex-specific biological constant for the Mifflin-St Jeor metabolic formula.

#### 5.2 Entering Body Measurements
1. **Height (cm)**: Enter your height in centimeters (e.g., `175` or `168.5`).
   - Allowed range: `50.0` to `260.0` cm.
2. **Weight (kg)**: Enter your current body weight in kilograms (e.g., `70` or `64.2`).
   - Allowed range: `10.0` to `400.0` kg.

#### 5.3 Selecting Activity Level
Select the option from the dropdown menu that best matches your typical weekly routine:
- **Sedentary (1.2x)**: Desk job, minimal or no deliberate exercise.
- **Lightly Active (1.375x)**: Light physical movement or sports 1–3 days per week.
- **Moderately Active (1.55x)**: Moderate physical exercise 3–5 days per week.
- **Very Active (1.725x)**: Intense training or physical labor 6–7 days per week.
- **Extra Active (1.9x)**: High-performance athletics, twice-daily training, or heavy construction.

#### 5.4 Selecting Caloric Objective
Choose your weight management preference:
- **Maintain Weight**: Balances daily intake with expenditure (0 kcal offset).
- **Gradual Loss (-300 kcal)**: Creates a modest, safe calorie deficit.
- **Gradual Gain (+300 kcal)**: Provides a slight surplus for gradual weight/muscle accretion.

#### 5.5 Executing Calculation
Tap the primary **Calculate** button.
- If any input is blank or outside valid ranges, red error messages will appear beneath the problematic field.
- If all values are valid, the screen dynamically displays the calculated results. On mobile devices, the screen smoothly scrolls to the results.

---

### 6. Interpreting Your Results

#### 6.1 Body Mass Index (BMI) & Visual Spectrum
- **Display**: Displays your calculated BMI in $\text{kg/m}^2$, rounded to one decimal place.
- **Category Badge**: Classified according to standard WHO guidelines:
  - **Underweight**: BMI $< 18.5$ (Sky Blue)
  - **Normal weight**: $18.5 \le \text{BMI} < 25.0$ (Emerald Green)
  - **Overweight**: $25.0 \le \text{BMI} < 30.0$ (Warm Amber)
  - **Obesity**: $\text{BMI} \ge 30.0$ (Crimson Red)
- **Spectrum Gauge**: A horizontal visual indicator with boundary tick-marks pointing directly to your position on the scale.

#### 6.2 Basal Metabolic Rate (BMR)
- Expressed in **kcal / day**.
- Represents the baseline calories consumed by vital physiological processes (cellular maintenance, breathing, brain function, heart contractions) while at complete physical rest.

#### 6.3 Daily Maintenance Calories (TDEE)
- Expressed in **kcal / day**.
- Calculated as: $\text{TDEE} = \text{BMR} \times \text{Activity Multiplier}$.
- This is the estimated daily caloric energy needed to sustain your current body weight at your declared activity level.

#### 6.4 Weight Objective Caloric Adjustment
- Shows your adjusted daily caloric target.
- **Interactive Switcher**: You can tap between Maintain, Gradual Loss, and Gradual Gain chips right inside the results card to instantly see target comparisons without re-entering form data.

#### 6.5 Pediatric & Adolescent Notice
When the entered age is under 18:
- Adult BMI classifications and adult calorie targets are suppressed.
- A prominent clinical notification advises that youth body composition changes dynamically with growth, requiring age-and-sex specific growth charts (CDC/WHO percentiles) interpreted by a pediatrician.

#### 6.6 Lifestyle & Nutrition Recommendations
Provides actionable, non-prescriptive advice emphasizing:
- Whole-food nutrition and adequate protein intake.
- Hydration targets (2–3 liters daily).
- At least 150 minutes of weekly moderate cardiovascular exercise.
- 7–9 hours of consistent, restorative sleep.

---

### 7. Resetting the Calculator
To clear all data:
1. Tap the **Reset** button on the form.
2. All inputs, validation errors, and calculated result cards will be cleared immediately.
3. The interface returns to the friendly empty state awaiting new measurements.

---

### 8. Privacy, Data Security & Offline Use
- **100% Offline**: All calculations execute strictly in your local device memory using Dart.
- **Zero Data Collection**: No cookies, no trackers, no telemetry, and no remote network requests are made.
- **Session Only**: Entered measurements are held in temporary memory during execution and are never written to unencrypted permanent storage.

---

### 9. Frequently Asked Questions (FAQ)

**Q1: Why does BMI categorize me as overweight if I lift weights regularly?**  
*A: BMI is a general ratio of mass to height. It does not measure body composition directly and cannot distinguish between dense lean muscle tissue and adipose fat. Athletes and muscular individuals should use body composition scans (DEXA, calipers) or consult a sports nutritionist.*

**Q2: Are the BMR equations exact?**  
*A: The Mifflin-St Jeor equation is one of the most widely validated predictive models in clinical nutrition, but individual metabolic rates vary based on thyroid function, genetics, muscle mass, and climate.*

**Q3: Can children use this calculator?**  
*A: Yes, but the app safely identifies ages under 18, suppresses adult cutoffs, and provides pediatric health education.*

---

### 10. Health & Safety Disclaimer
> [!IMPORTANT]
> This application is strictly an educational tool designed for academic demonstration and general wellness self-awareness. It is **not** a certified medical diagnostic device. Do not use its output to diagnose illnesses, manage clinical conditions, or replace professional consultation with a licensed physician or registered dietitian.
