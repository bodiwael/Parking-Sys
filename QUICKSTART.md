# Quick Start Guide - Smart Parking System

Get your Smart Parking System up and running in 30 minutes!

## Prerequisites

Before you begin, gather:
- ✅ ESP32 + 3 ultrasonic sensors + LCD + batteries (assembled)
- ✅ Computer with Arduino IDE installed
- ✅ Smartphone with Android/iOS
- ✅ WiFi network credentials
- ✅ Gmail account (for Firebase)

## Step-by-Step Setup

### Phase 1: Firebase Setup (5 minutes)

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add project" → Name it "smart-parking" → Create

2. **Enable Database**
   - Click "Realtime Database" → "Create Database"
   - Choose location → Start in "Test mode" → Enable

3. **Get Credentials**
   - Copy the database URL (e.g., `smart-parking-xyz.firebaseio.com`)
   - Go to Project Settings → Service Accounts → Database Secrets
   - Copy the secret key

4. **Download Config File**
   - Click Android icon → Package: `com.example.smart_parking_app`
   - Download `google-services.json`
   - Save it for later

### Phase 2: ESP32 Setup (10 minutes)

1. **Install Libraries**
   - Open Arduino IDE
   - Tools → Manage Libraries
   - Install: "Firebase ESP32 Client" by Mobizt
   - Install: "LiquidCrystal I2C"

2. **Configure Code**
   - Open `esp32_code/smart_parking.ino`
   - Update these lines:
   ```cpp
   #define WIFI_SSID "YourWiFiName"
   #define WIFI_PASSWORD "YourWiFiPassword"
   #define FIREBASE_HOST "smart-parking-xyz.firebaseio.com"
   #define FIREBASE_AUTH "your_secret_from_step_3"
   ```

3. **Upload to ESP32**
   - Connect ESP32 via USB
   - Tools → Board → "ESP32 Dev Module"
   - Tools → Port → Select your ESP32 port
   - Click Upload ⬆️
   - Wait for "Done uploading"

4. **Test ESP32**
   - Open Serial Monitor (115200 baud)
   - You should see: "WiFi Connected!" and "Firebase initialized!"
   - LCD should show slot status

### Phase 3: Flutter App Setup (15 minutes)

1. **Install Flutter** (if not installed)
   - Download from https://flutter.dev
   - Follow OS-specific installation
   - Run `flutter doctor` to verify

2. **Place Firebase Config**
   ```bash
   # Copy the google-services.json from Phase 1
   cp /path/to/google-services.json flutter_app/android/app/
   ```

3. **Install Dependencies**
   ```bash
   cd flutter_app
   flutter pub get
   ```

4. **Run the App**
   - Connect phone via USB (enable USB debugging on Android)
   - Or start Android emulator
   ```bash
   flutter run
   ```

5. **App should launch!**
   - Wait for compilation (~2 minutes first time)
   - App opens showing parking dashboard

## Verification Checklist

### ESP32 is working if:
- ✅ LCD shows "A:O B:O C:O Free: 3/3"
- ✅ Serial Monitor shows "Data sent to Firebase successfully!"
- ✅ When you put hand near sensor, LCD changes (O → X)

### Firebase is working if:
- ✅ Go to Firebase Console → Realtime Database → Data
- ✅ You see `parking/slots/slotA/occupied: false`
- ✅ Value changes when you trigger sensor

### Flutter App is working if:
- ✅ System status shows green "Online"
- ✅ You see 3 parking slot cards (green = available)
- ✅ Statistics show "Available: 3"
- ✅ When you trigger sensor, card turns red in real-time

## Testing the System

1. **Power on ESP32**
   - LCD should light up
   - Shows "Smart Parking" then connects to WiFi

2. **Open Flutter App**
   - Should show "Online" status
   - All 3 slots green (available)

3. **Test Detection**
   - Place object in front of Sensor A (< 15cm)
   - Watch LCD change: "A:X B:O C:O Free: 2/3"
   - Watch Flutter app: Slot A turns RED
   - Statistics update: "Available: 2"

4. **Test Real-time Sync**
   - Remove object
   - LCD changes back: "A:O..."
   - Flutter app: Slot A turns GREEN
   - Updates happen within 1 second!

## Common Issues & Quick Fixes

| Problem | Solution |
|---------|----------|
| ESP32 won't connect to WiFi | Check SSID/password, use 2.4GHz WiFi |
| LCD blank | Try I2C address 0x3F instead of 0x27 |
| Firebase permission error | Set database rules to test mode (see docs) |
| Flutter app crashes | Run `flutter clean && flutter pub get` |
| Sensor always shows occupied | Adjust DISTANCE_THRESHOLD in code |
| App shows "offline" | Check ESP32 Serial Monitor for errors |

## Next Steps

Once everything works:

1. **Calibrate Sensors**
   - Adjust `DISTANCE_THRESHOLD` for your use case
   - Test with actual vehicles if possible

2. **Optimize Power**
   - Test battery life
   - Adjust `UPDATE_INTERVAL` to save power

3. **Secure Firebase**
   - Change database rules from test mode
   - Implement authentication (see docs)

4. **Customize App**
   - Change colors in Flutter code
   - Modify slot names
   - Add your branding

## Get Help

If stuck:
1. Check full documentation in `docs/` folder
2. Review troubleshooting sections in README
3. Check Serial Monitor output from ESP32
4. Verify Firebase Console data tab

## Success! 🎉

Your Smart Parking System is now:
- ✅ Detecting parking slots in real-time
- ✅ Syncing to cloud via Firebase
- ✅ Displaying on mobile app
- ✅ Running on battery power

**Time to build more slots or add advanced features!**

---

**Total Setup Time**: ~30 minutes
**Difficulty**: Intermediate
**Result**: Fully functional IoT parking system!
