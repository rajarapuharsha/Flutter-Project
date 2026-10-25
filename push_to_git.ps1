# PowerShell Script to push to GitHub repository
$ErrorActionPreference = "Continue"

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "Pushing BMI & Daily Calorie Calculator to GitHub" -ForegroundColor Cyan
Write-Host "Repository: https://github.com/rajarapuharsha/Flutter-Project.git" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

Set-Location -Path $PSScriptRoot

Write-Host "`n[1/5] Initializing Git repository..." -ForegroundColor Yellow
git init

Write-Host "`n[2/5] Staging files..." -ForegroundColor Yellow
git add .

Write-Host "`n[3/5] Committing changes..." -ForegroundColor Yellow
git commit -m "feat: complete BMI & Daily Calorie Calculator (UN SDG 3) with white input text styling"

Write-Host "`n[4/5] Setting main branch and remote origin..." -ForegroundColor Yellow
git branch -M main
git remote remove origin 2>$null
git remote add origin https://github.com/rajarapuharsha/Flutter-Project.git

Write-Host "`n[5/5] Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "`nHandling remote changes if any..." -ForegroundColor Yellow
    git pull origin main --rebase
    git push -u origin main
}

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host "Successfully pushed! View your code at:" -ForegroundColor Green
Write-Host "https://github.com/rajarapuharsha/Flutter-Project" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
