@echo off
echo ========================================================
echo Pushing BMI & Daily Calorie Calculator to GitHub
echo Repository: https://github.com/rajarapuharsha/Flutter-Project.git
echo ========================================================

cd /d "%~dp0"

echo [1/5] Initializing Git repository...
git init

echo [2/5] Staging files...
git add .

echo [3/5] Committing changes...
git commit -m "feat: complete BMI & Daily Calorie Calculator (UN SDG 3) with white input text styling"

echo [4/5] Setting main branch and remote origin...
git branch -M main
git remote remove origin >nul 2>&1
git remote add origin https://github.com/rajarapuharsha/Flutter-Project.git

echo [5/5] Pushing to GitHub...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo --------------------------------------------------------
    echo Remote has existing commits (e.g., initial README on GitHub).
    echo Pulling remote changes with unrelated histories...
    git pull origin main --allow-unrelated-histories --no-rebase -m "Merge remote-tracking branch 'origin/main'"
    git push -u origin main
)

if %errorlevel% neq 0 (
    echo.
    echo --------------------------------------------------------
    echo Overwriting remote placeholder with local project files...
    git push -u origin main --force
)

echo.
echo ========================================================
echo Done! Check your repository at:
echo https://github.com/rajarapuharsha/Flutter-Project
echo ========================================================
pause
