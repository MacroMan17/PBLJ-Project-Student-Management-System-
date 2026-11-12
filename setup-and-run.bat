@echo off
REM ========================================
REM Student Management System Setup & Run
REM ========================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ========================================
echo Student Management System Setup
echo ========================================
echo.

REM Check Java
echo Checking Java installation...
java -version 2>&1 | findstr /I "version" >nul
if errorlevel 1 (
    echo ERROR: Java not found. Please install Java 17 or higher.
    pause
    exit /b 1
)
echo ✓ Java found
echo.

REM Check Maven
echo Checking Maven installation...
mvn -v 2>&1 | findstr /I "maven" >nul
if errorlevel 1 (
    echo WARNING: Maven not found in PATH
    echo.
    echo Options:
    echo 1. Install Maven from: https://maven.apache.org/download.cgi
    echo 2. Use Chocolatey: choco install maven
    echo 3. Add Maven to PATH if already installed
    echo.
    echo Press Ctrl+C to exit and install Maven first.
    pause
) else (
    echo ✓ Maven found
    echo.
)

REM Check MySQL
echo Checking MySQL...
netstat -ano | findstr ":3306" >nul
if errorlevel 1 (
    echo WARNING: MySQL does not appear to be running on port 3306
    echo.
    echo To start MySQL:
    echo - Windows: net start MySQL80
    echo - Or find MySQL in Services and start it
    echo.
    echo Please start MySQL before continuing.
    pause
) else (
    echo ✓ MySQL found on port 3306
    echo.
)

REM Setup Database
echo Setting up database...
echo.
echo Database setup instructions:
echo.
echo 1. Open MySQL Command Line or MySQL Workbench
echo 2. Run these commands:
echo    CREATE DATABASE IF NOT EXISTS student_db;
echo    USE student_db;
echo.
echo 3. Then execute the schema:
echo    mysql -u root -p student_db ^< database\schema.sql
echo.
echo.
pause

REM Update configuration reminder
echo Before running, ensure database credentials in:
echo src/main/resources/application.yml
echo are set correctly.
echo.
pause

REM Build
echo.
echo ========================================
echo Building Project...
echo ========================================
echo.

call mvn clean install -DskipTests

if errorlevel 1 (
    echo.
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build Successful!
echo ========================================
echo.

REM Run
echo.
echo ========================================
echo Starting Application...
echo ========================================
echo.
echo API will run on: http://localhost:8080
echo.
echo Available endpoints:
echo   POST   /api/students
echo   GET    /api/students
echo   GET    /api/students/{id}
echo   PUT    /api/students/{id}
echo   DELETE /api/students/{id}
echo   GET    /api/students/course/{course}
echo.
echo Press Ctrl+C to stop the application.
echo.
echo ========================================
echo.

call mvn spring-boot:run

pause
