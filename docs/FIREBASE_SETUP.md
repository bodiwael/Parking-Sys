# Firebase Setup Guide

Complete step-by-step guide to set up Firebase for the Smart Parking System.

## Overview

This system uses Firebase Realtime Database to sync data between ESP32 and the Flutter app in real-time.

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter project name: `smart-parking-system` (or your preferred name)
4. Click **Continue**
5. Disable Google Analytics (optional, but recommended for simplicity)
6. Click **Create project**
7. Wait for project creation (~30 seconds)
8. Click **Continue**

## Step 2: Enable Realtime Database

1. In the left sidebar, click **"Realtime Database"**
2. Click **"Create Database"**
3. Select database location (choose closest to your location):
   - `us-central1` (United States)
   - `europe-west1` (Belgium)
   - `asia-southeast1` (Singapore)
4. Click **Next**
5. Choose **"Start in test mode"** (for development)
6. Click **Enable**

### Important: Database URL

After creation, you'll see your database URL:
```
https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com/
```

**Copy this URL!** You'll need it for:
- ESP32 configuration (without https://)
- Flutter configuration (included in google-services.json)

## Step 3: Configure Database Rules

By default, test mode rules expire after 30 days. Set permanent rules:

1. Click on the **"Rules"** tab
2. Replace with these rules:

```json
{
  "rules": {
    "parking": {
      ".read": true,
      ".write": true
    }
  }
}
```

3. Click **Publish**

### Security Note

These rules allow anyone to read/write to the `/parking` path. For production:

```json
{
  "rules": {
    "parking": {
      ".read": true,
      ".write": "auth != null"  // Only authenticated users can write
    }
  }
}
```

## Step 4: Get Database Secret (for ESP32)

1. Click the gear icon ⚙️ next to "Project Overview"
2. Select **"Project settings"**
3. Go to **"Service accounts"** tab
4. Click **"Database secrets"**
5. Click **"Show"** on the secret
6. **Copy the secret key**

**Keep this secret secure!** This is needed for ESP32 to authenticate.

## Step 5: Setup Flutter App (Android)

### A. Register Android App

1. In Firebase Console, click **"Project Overview"**
2. Click the **Android icon** to add an Android app
3. Enter Android package name: `com.example.smart_parking_app`
4. App nickname (optional): "Smart Parking App"
5. Click **"Register app"**

### B. Download Configuration File

1. Download `google-services.json`
2. Place it in your Flutter project:
   ```
   flutter_app/android/app/google-services.json
   ```

### C. Add Firebase SDK (Already done in code)

The `android/build.gradle` and `android/app/build.gradle` are already configured in the Flutter app code.

### D. Verify Package Name

Edit `flutter_app/android/app/build.gradle` and ensure:

```gradle
android {
    defaultConfig {
        applicationId "com.example.smart_parking_app"  // Must match Firebase
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

## Step 6: Setup Flutter App (iOS) - Optional

Only if you plan to run on iOS:

### A. Register iOS App

1. In Firebase Console, click the **iOS icon**
2. Enter iOS bundle ID: `com.example.smartParkingApp`
3. Click **"Register app"**

### B. Download Configuration File

1. Download `GoogleService-Info.plist`
2. Open Xcode
3. Drag `GoogleService-Info.plist` into the `Runner` folder
4. Ensure "Copy items if needed" is checked

## Step 7: Configure ESP32

Update the ESP32 code with your Firebase credentials:

```cpp
// In esp32_code/smart_parking.ino

#define FIREBASE_HOST "YOUR_PROJECT_ID-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "YOUR_DATABASE_SECRET_FROM_STEP_4"
```

**Example:**
```cpp
#define FIREBASE_HOST "smart-parking-abc123-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "X9kP2mN8qL4vB6tY1cR5wE7sA3dF9gH0"
```

## Step 8: Test Database Connection

### Method 1: Using Firebase Console

1. Go to Realtime Database
2. Click on the **"Data"** tab
3. You should see data structure like:

```
parking/
  ├── slots/
  │   ├── slotA/
  │   │   ├── name: "Slot A"
  │   │   └── occupied: false
  │   ├── slotB/
  │   └── slotC/
  ├── summary/
  │   ├── totalSlots: 3
  │   ├── availableSlots: 3
  │   └── occupiedSlots: 0
  └── system/
      ├── name: "Smart Parking System"
      ├── location: "Main Parking Area"
      └── status: "online"
```

### Method 2: Manual Data Entry (for testing without ESP32)

1. In Firebase Console → Realtime Database → Data tab
2. Click the **"+"** icon next to the database URL
3. Add sample data:

**Name:** `parking`
**Value:** Click "Import JSON" and paste:

```json
{
  "slots": {
    "slotA": {
      "name": "Slot A",
      "occupied": false
    },
    "slotB": {
      "name": "Slot B",
      "occupied": true
    },
    "slotC": {
      "name": "Slot C",
      "occupied": false
    }
  },
  "summary": {
    "totalSlots": 3,
    "availableSlots": 2,
    "occupiedSlots": 1,
    "lastUpdate": 0
  },
  "system": {
    "name": "Smart Parking System",
    "location": "Test Location",
    "status": "online"
  }
}
```

4. Click **Import**
5. Now run the Flutter app - you should see the data!

## Step 9: Verify Everything Works

### Test Checklist:

- [ ] Firebase project created
- [ ] Realtime Database enabled
- [ ] Database rules published
- [ ] Database secret obtained
- [ ] `google-services.json` downloaded and placed
- [ ] ESP32 code updated with Firebase credentials
- [ ] ESP32 uploaded and running
- [ ] Flutter app runs without errors
- [ ] Flutter app shows parking slot data
- [ ] Data updates in real-time when ESP32 detects changes

## Troubleshooting

### "Permission denied" error:
- Check database rules allow read/write
- Verify ESP32 is using correct database secret

### Flutter app shows "No parking slots found":
- Check ESP32 is connected to WiFi
- Verify ESP32 is sending data to Firebase
- Check Firebase Console → Database → Data tab for data
- Ensure Flutter app has correct `google-services.json`

### ESP32 not connecting to Firebase:
- Verify `FIREBASE_HOST` is correct (without https://)
- Check `FIREBASE_AUTH` secret is correct
- Ensure WiFi is connected
- Check Serial Monitor for error messages

### Flutter build errors:
- Ensure `google-services.json` is in `android/app/` folder
- Run `flutter clean && flutter pub get`
- Check `minSdkVersion` is 21 or higher

## Cost Information

Firebase Realtime Database Free Tier (Spark Plan):
- **1 GB stored data** - More than enough for this project
- **10 GB/month downloaded** - Sufficient for multiple users
- **100 simultaneous connections** - Perfect for this use case

This project uses approximately:
- **Storage**: < 1 KB
- **Bandwidth**: ~1 MB/month (with continuous monitoring)

**Conclusion**: This project will stay within the free tier indefinitely! 🎉

## Next Steps

1. **Secure your database** - Implement proper authentication for production
2. **Monitor usage** - Check Firebase Console → Usage tab
3. **Backup data** - Export database regularly
4. **Add features** - Extend the database structure for new features

## Database Structure Reference

```
parking/
├── slots/                    # Individual slot status
│   ├── slotA/
│   │   ├── name: String     # Display name
│   │   └── occupied: Bool   # Occupancy status
│   ├── slotB/
│   └── slotC/
│
├── summary/                  # Aggregate data
│   ├── totalSlots: Int      # Total number of slots
│   ├── availableSlots: Int  # Count of free slots
│   ├── occupiedSlots: Int   # Count of occupied slots
│   └── lastUpdate: Int      # Timestamp (seconds since boot)
│
└── system/                   # System information
    ├── name: String         # System name
    ├── location: String     # Physical location
    └── status: String       # "online" or "offline"
```

## Support

For issues:
1. Check Firebase Console logs
2. Check ESP32 Serial Monitor output
3. Check Flutter debug console
4. Verify all configuration files are correct
