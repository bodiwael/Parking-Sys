# Smart Parking Flutter App

A beautiful and simple Flutter app for monitoring parking slot availability in real-time.

## Features

- Real-time parking slot monitoring
- Beautiful, modern UI with gradient cards
- Statistics dashboard
- System status indicator
- Automatic updates from Firebase
- Offline/Online status detection

## Setup Instructions

### 1. Install Flutter

Download and install Flutter from [flutter.dev](https://flutter.dev)

Verify installation:
```bash
flutter doctor
```

### 2. Firebase Setup

#### A. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name (e.g., "smart-parking-system")
4. Disable Google Analytics (optional)
5. Click "Create project"

#### B. Enable Realtime Database

1. In Firebase Console, go to "Realtime Database"
2. Click "Create Database"
3. Select location (closest to you)
4. Start in **Test Mode** (for development)
5. Click "Enable"

#### C. Set Database Rules (for testing)

Go to "Rules" tab and use these rules:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

**Note:** These rules allow public read/write. For production, implement proper security rules.

#### D. Get Database URL and Secret

1. Database URL: Copy from the Realtime Database page (e.g., `https://your-project.firebaseio.com`)
2. Database Secret:
   - Go to Project Settings → Service Accounts
   - Click "Database secrets"
   - Show and copy the secret

**Save these for ESP32 configuration!**

### 3. Add Firebase to Flutter App

#### For Android:

1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.example.smart_parking_app`
3. Download `google-services.json`
4. Place it in: `flutter_app/android/app/google-services.json`

5. Edit `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

6. Edit `android/app/build.gradle`:
```gradle
// Add at the top
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

// Add at the bottom
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21  // Change from 19 to 21
    }
}
```

#### For iOS:

1. In Firebase Console, click "Add app" → iOS
2. Enter bundle ID: `com.example.smartParkingApp`
3. Download `GoogleService-Info.plist`
4. Place it in: `flutter_app/ios/Runner/GoogleService-Info.plist`

### 4. Install Dependencies

Navigate to the flutter_app directory:
```bash
cd flutter_app
flutter pub get
```

### 5. Run the App

#### On Android:
```bash
flutter run
```

#### On iOS (Mac only):
```bash
cd ios
pod install
cd ..
flutter run
```

#### On Web:
```bash
flutter run -d chrome
```

## Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/
│   │   ├── parking_slot.dart  # Parking slot model
│   │   └── parking_summary.dart # Summary model
│   ├── screens/
│   │   └── home_screen.dart   # Main screen
│   ├── services/
│   │   └── firebase_service.dart # Firebase operations
│   └── widgets/
│       ├── parking_slot_card.dart # Slot card widget
│       └── stats_card.dart    # Statistics card widget
└── pubspec.yaml               # Dependencies
```

## Firebase Database Structure

The app expects this structure in Firebase Realtime Database:

```json
{
  "parking": {
    "slots": {
      "slotA": {
        "name": "Slot A",
        "occupied": false
      },
      "slotB": {
        "name": "Slot B",
        "occupied": false
      },
      "slotC": {
        "name": "Slot C",
        "occupied": false
      }
    },
    "summary": {
      "totalSlots": 3,
      "availableSlots": 3,
      "occupiedSlots": 0,
      "lastUpdate": 1234567890
    },
    "system": {
      "name": "Smart Parking System",
      "location": "Main Parking Area",
      "status": "online"
    }
  }
}
```

This structure is automatically created by the ESP32 code.

## Customization

### Change App Name

Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="Smart Parking">
```

### Change Theme Colors

Edit `lib/main.dart`:
```dart
theme: ThemeData(
  primarySwatch: Colors.blue, // Change to your preferred color
),
```

### Modify Slot Card Design

Edit `lib/widgets/parking_slot_card.dart` to customize the appearance.

## Troubleshooting

### Firebase not connecting:
- Verify `google-services.json` is in correct location
- Check package name matches Firebase configuration
- Ensure Realtime Database is enabled
- Check internet connection

### Build errors:
- Run `flutter clean`
- Run `flutter pub get`
- Check minimum SDK version (should be 21+)

### Slots not showing:
- Verify ESP32 is running and connected
- Check Firebase Realtime Database for data
- Ensure database rules allow read access
- Check system status indicator (should be green/online)

### Hot reload not working:
- Restart app completely
- Check for syntax errors

## Performance

- Real-time updates with minimal latency
- Efficient Firebase listeners
- Optimized for battery usage
- Smooth animations and transitions

## Requirements

- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher
- Android 5.0 (API 21) or higher
- iOS 12.0 or higher

## License

This project is open source and available for educational purposes.
