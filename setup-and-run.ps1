#!/usr/bin/env pwsh
# ========================================
# Student Management System Setup & Run
# ========================================

$ErrorActionPreference = "Continue"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Student Management System Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check Java
Write-Host "Checking Java installation..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1
    if ($javaVersion -match "17|18|19|20|21") {
        Write-Host "✓ Java found" -ForegroundColor Green
        java -version 2>&1 | Select-Object -First 1
    }
} catch {
    Write-Host "✗ Java not found. Please install Java 17 or higher." -ForegroundColor Red
    Write-Host "Download from: https://adoptium.net/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Check Maven
Write-Host "Checking Maven installation..." -ForegroundColor Yellow
try {
    $mvnVersion = mvn -v 2>&1
    if ($mvnVersion -match "Maven") {
        Write-Host "✓ Maven found" -ForegroundColor Green
        mvn -v | Select-Object -First 1
    }
} catch {
    Write-Host "✗ Maven not found in PATH" -ForegroundColor Red
    Write-Host "`nOptions to install Maven:" -ForegroundColor Yellow
    Write-Host "1. Download: https://maven.apache.org/download.cgi" -ForegroundColor Yellow
    Write-Host "2. Use Chocolatey: choco install maven" -ForegroundColor Yellow
    Write-Host "3. Use Scoop: scoop install maven" -ForegroundColor Yellow
    Write-Host "`nPlease install Maven and add it to PATH, then run this script again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Check MySQL
Write-Host "Checking MySQL..." -ForegroundColor Yellow
$mysqlRunning = Get-NetTCPConnection -LocalPort 3306 -ErrorAction SilentlyContinue
if ($mysqlRunning) {
    Write-Host "✓ MySQL found on port 3306" -ForegroundColor Green
} else {
    Write-Host "⚠ MySQL does not appear to be running on port 3306" -ForegroundColor Yellow
    Write-Host "`nTo start MySQL:" -ForegroundColor Yellow
    Write-Host "- Windows Service: net start MySQL80" -ForegroundColor Yellow
    Write-Host "- Or start from Services.msc" -ForegroundColor Yellow
    Write-Host "`nPlease start MySQL first!" -ForegroundColor Yellow
}
Write-Host ""

# Database setup instructions
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database Setup Required" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Please follow these steps:" -ForegroundColor Yellow
Write-Host "`n1. Open MySQL Command Line or MySQL Workbench`n" -ForegroundColor White
Write-Host "2. Run this command:" -ForegroundColor Yellow
Write-Host "   CREATE DATABASE IF NOT EXISTS student_db;" -ForegroundColor Gray
Write-Host "`n3. Then execute the schema script:" -ForegroundColor Yellow
Write-Host "   mysql -u root -p student_db < database\schema.sql" -ForegroundColor Gray
Write-Host "`n4. Update credentials in: src/main/resources/application.yml" -ForegroundColor Yellow
Write-Host "`n   spring:" -ForegroundColor Gray
Write-Host "     datasource:" -ForegroundColor Gray
Write-Host "       username: root    # Your MySQL username" -ForegroundColor Gray
Write-Host "       password: root    # Your MySQL password" -ForegroundColor Gray

Write-Host "`n`nPress Enter to continue when ready..." -ForegroundColor Yellow
Read-Host

# Build
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Building Project..." -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Running: mvn clean install -DskipTests`n" -ForegroundColor Yellow

& mvn clean install -DskipTests

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n✗ Build failed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Build Successful!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

# Run
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Application..." -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "API will run on: http://localhost:8080`n" -ForegroundColor Cyan

Write-Host "Available endpoints:" -ForegroundColor Yellow
Write-Host "  POST   /api/students" -ForegroundColor Gray
Write-Host "  GET    /api/students" -ForegroundColor Gray
Write-Host "  GET    /api/students/{id}" -ForegroundColor Gray
Write-Host "  PUT    /api/students/{id}" -ForegroundColor Gray
Write-Host "  DELETE /api/students/{id}" -ForegroundColor Gray
Write-Host "  GET    /api/students/course/{course}" -ForegroundColor Gray

Write-Host "`nPress Ctrl+C to stop the application.`n" -ForegroundColor Yellow

Write-Host "Starting..." -ForegroundColor Yellow
Write-Host ""

& mvn spring-boot:run

Read-Host "Press Enter to exit"
