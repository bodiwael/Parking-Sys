#!/bin/bash

# Quick script to generate temporary placeholder icons
# This creates minimal working icons so you can test the app

echo "Creating placeholder icons..."

# Create directories
mkdir -p assets/icon
mkdir -p android/app/src/main/res/mipmap-mdpi
mkdir -p android/app/src/main/res/mipmap-hdpi
mkdir -p android/app/src/main/res/mipmap-xhdpi
mkdir -p android/app/src/main/res/mipmap-xxhdpi
mkdir -p android/app/src/main/res/mipmap-xxxhdpi

# Method 1: If ImageMagick is installed
if command -v convert &> /dev/null; then
    echo "ImageMagick found! Generating icons..."

    # Generate main icon
    convert -size 512x512 xc:#2196F3 -gravity center -pointsize 300 -fill white -annotate +0+0 "P" assets/icon/app_icon.png
    cp assets/icon/app_icon.png assets/icon/foreground.png

    # Generate different sizes
    convert assets/icon/app_icon.png -resize 48x48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png
    convert assets/icon/app_icon.png -resize 72x72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png
    convert assets/icon/app_icon.png -resize 96x96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
    convert assets/icon/app_icon.png -resize 144x144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
    convert assets/icon/app_icon.png -resize 192x192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

    echo "✅ Icons generated successfully!"
    echo "Now run: flutter run"

# Method 2: Download a free icon
else
    echo "ImageMagick not found. Downloading a free parking icon..."

    # Try to download a free parking icon
    if command -v curl &> /dev/null; then
        curl -L "https://cdn-icons-png.flaticon.com/512/3448/3448636.png" -o assets/icon/app_icon.png
        cp assets/icon/app_icon.png assets/icon/foreground.png

        echo "✅ Icon downloaded!"
        echo "Now run:"
        echo "  flutter pub get"
        echo "  dart run flutter_launcher_icons"
        echo "  flutter run"
    else
        echo ""
        echo "❌ Neither ImageMagick nor curl found."
        echo ""
        echo "Please manually create a 512x512 PNG icon:"
        echo "1. Create a blue square (any image editor)"
        echo "2. Add white 'P' text in center"
        echo "3. Save as: assets/icon/app_icon.png"
        echo "4. Copy to: assets/icon/foreground.png"
        echo ""
        echo "Then run:"
        echo "  flutter pub get"
        echo "  dart run flutter_launcher_icons"
        echo "  flutter run"
    fi
fi
