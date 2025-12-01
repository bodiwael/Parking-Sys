@echo off
REM Quick script to download and generate placeholder icons for Windows
REM This creates minimal working icons so you can test the app

echo Creating placeholder icons...

REM Create directories
if not exist "assets\icon" mkdir assets\icon
if not exist "android\app\src\main\res\mipmap-mdpi" mkdir android\app\src\main\res\mipmap-mdpi
if not exist "android\app\src\main\res\mipmap-hdpi" mkdir android\app\src\main\res\mipmap-hdpi
if not exist "android\app\src\main\res\mipmap-xhdpi" mkdir android\app\src\main\res\mipmap-xhdpi
if not exist "android\app\src\main\res\mipmap-xxhdpi" mkdir android\app\src\main\res\mipmap-xxhdpi
if not exist "android\app\src\main\res\mipmap-xxxhdpi" mkdir android\app\src\main\res\mipmap-xxxhdpi

echo.
echo ============================================
echo   OPTION 1: Download Free Parking Icon
echo ============================================
echo.
echo I'll try to download a free parking icon for you...
echo.

REM Try to download using PowerShell
powershell -Command "& {Invoke-WebRequest -Uri 'https://cdn-icons-png.flaticon.com/512/3448/3448636.png' -OutFile 'assets\icon\app_icon.png'}" 2>nul

if exist "assets\icon\app_icon.png" (
    echo SUCCESS! Icon downloaded.
    copy /Y assets\icon\app_icon.png assets\icon\foreground.png >nul
    echo.
    echo ===================================
    echo   Now run these commands:
    echo ===================================
    echo.
    echo   flutter pub get
    echo   dart run flutter_launcher_icons
    echo   flutter run
    echo.
    pause
) else (
    echo.
    echo Download failed or blocked by firewall.
    echo.
    echo ============================================
    echo   OPTION 2: Manual Icon Creation
    echo ============================================
    echo.
    echo Please create a simple icon manually:
    echo.
    echo 1. Open Paint or any image editor
    echo 2. Create a 512x512 pixel image
    echo 3. Fill with blue color ^(#2196F3^)
    echo 4. Add white text "P" in center
    echo 5. Save as PNG:
    echo    - assets\icon\app_icon.png
    echo    - assets\icon\foreground.png
    echo.
    echo OR download from: https://www.flaticon.com/free-icon/parking_3448636
    echo    ^(Choose 512px PNG format^)
    echo.
    echo Then run:
    echo   flutter pub get
    echo   dart run flutter_launcher_icons
    echo   flutter run
    echo.
    pause
)
