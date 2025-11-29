# ESP32 Smart Parking Code

## Required Libraries

Install these libraries via Arduino IDE Library Manager:

1. **Firebase ESP32 Client** by Mobizt
   - Library Manager → Search "Firebase ESP32" → Install
   - Version: 4.3.x or later

2. **LiquidCrystal I2C** by Frank de Brabander
   - Library Manager → Search "LiquidCrystal I2C" → Install
   - Version: 1.1.2 or later

## Configuration Steps

### 1. Update WiFi Credentials

Open `smart_parking.ino` and update:

```cpp
#define WIFI_SSID "YOUR_WIFI_SSID"        // Your WiFi network name
#define WIFI_PASSWORD "YOUR_WIFI_PASSWORD" // Your WiFi password
```

### 2. Update Firebase Configuration

```cpp
#define FIREBASE_HOST "YOUR_PROJECT_ID.firebaseio.com"
#define FIREBASE_AUTH "YOUR_FIREBASE_DATABASE_SECRET"
```

**Getting Firebase credentials:**
- FIREBASE_HOST: Go to Firebase Console → Realtime Database → Copy the database URL (without https://)
- FIREBASE_AUTH: Project Settings → Service Accounts → Database Secrets → Show/Copy secret

### 3. Adjust LCD I2C Address (if needed)

Default address is `0x27`. If LCD doesn't work, try `0x3F`:

```cpp
#define LCD_ADDRESS 0x27  // Change to 0x3F if needed
```

**Finding I2C address:**
Use an I2C scanner sketch to detect the correct address.

### 4. Adjust Detection Threshold (optional)

```cpp
#define DISTANCE_THRESHOLD 15  // Distance in cm
```

Set based on your sensor mounting height and vehicle size.

## Upload Instructions

1. Connect ESP32 to computer via USB
2. Open `smart_parking.ino` in Arduino IDE
3. Select **Board**: "ESP32 Dev Module"
4. Select **Port**: Your ESP32's COM port
5. Click **Upload**
6. Open **Serial Monitor** (115200 baud) to view debug output

## Testing

1. Power on the system
2. Wait for WiFi connection (LCD will show status)
3. Place objects in front of sensors to simulate vehicles
4. Check LCD for slot status (O = available, X = occupied)
5. Verify Serial Monitor output
6. Check Firebase Realtime Database for data updates

## Troubleshooting

**Compilation errors:**
- Ensure all required libraries are installed
- Use ESP32 board package version 2.0.x or later

**LCD shows nothing:**
- Check I2C connections (SDA, SCL)
- Try different I2C address (0x27 or 0x3F)
- Adjust contrast potentiometer on LCD

**WiFi won't connect:**
- Verify SSID and password
- Check WiFi signal strength
- Use 2.4GHz WiFi (ESP32 doesn't support 5GHz)

**Firebase not updating:**
- Verify FIREBASE_HOST and FIREBASE_AUTH
- Check Realtime Database rules (set to public for testing)
- Check Serial Monitor for error messages

**Sensors giving wrong readings:**
- Check 5V power supply
- Verify TRIG and ECHO pin connections
- Ensure sensors face parking slots
- Keep sensor wiring under 30cm
