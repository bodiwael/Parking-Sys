# Hardware Connections Guide

## Components Required

### Main Components
- 1x ESP32 Development Board
- 3x HC-SR04 Ultrasonic Sensors
- 1x LCD 16x2 with I2C Module
- 2x 18650 Li-ion Batteries (3.7V each)
- 1x 5V Step-down Voltage Regulator (e.g., LM2596 or similar)
- 1x Battery holder for 2x 18650
- Jumper wires
- Breadboard (optional for prototyping)

### Power Supply Details
- **Input**: 2x 18650 batteries in series = 7.4V (nominal)
- **Regulation**: Step-down regulator converts 7.4V to 5V
- **Output**: 5V powers ESP32, sensors, and LCD

## Pin Connections

### Power Distribution
```
18650 Battery 1 (+) ----┐
                        ├---- Step-down VIN+
18650 Battery 2 (-)     │
                   |    │
18650 Battery 2 (+) ----┤
                        │
18650 Battery 1 (-) ----┴---- Step-down VIN- & Common GND

Step-down VOUT+ (5V) ---- ESP32 VIN (or 5V pin)
Step-down GND ----------- ESP32 GND
```

### ESP32 to Ultrasonic Sensors

**Sensor 1 (Slot A):**
- VCC → 5V (from step-down)
- GND → GND
- TRIG → GPIO 5
- ECHO → GPIO 18

**Sensor 2 (Slot B):**
- VCC → 5V (from step-down)
- GND → GND
- TRIG → GPIO 19
- ECHO → GPIO 21

**Sensor 3 (Slot C):**
- VCC → 5V (from step-down)
- GND → GND
- TRIG → GPIO 22
- ECHO → GPIO 23

### ESP32 to LCD 16x2 (I2C)
- VCC → 5V (from step-down)
- GND → GND
- SDA → GPIO 21 (default I2C SDA for ESP32)
- SCL → GPIO 22 (default I2C SCL for ESP32)

**Note**: If GPIO 21/22 conflict with sensor pins, use alternative I2C pins:
- Alternative SDA: GPIO 33
- Alternative SCL: GPIO 32

Update the code accordingly if using alternative pins.

## Connection Diagram (Text Format)

```
                    [18650 Battery Pack]
                           |
                    [5V Step-Down]
                           |
                          5V
                           |
        ┌──────────────────┼──────────────────┐
        |                  |                  |
   [ESP32]            [LCD I2C]        [3x Ultrasonic]
    WiFi                                      |
     |                                    Distance
     |                                    Detection
  Firebase
```

## Pin Summary Table

| Component | Pin Name | ESP32 GPIO |
|-----------|----------|------------|
| Sensor 1  | TRIG     | GPIO 5     |
| Sensor 1  | ECHO     | GPIO 18    |
| Sensor 2  | TRIG     | GPIO 19    |
| Sensor 2  | ECHO     | GPIO 21    |
| Sensor 3  | TRIG     | GPIO 22    |
| Sensor 3  | ECHO     | GPIO 23    |
| LCD I2C   | SDA      | GPIO 21*   |
| LCD I2C   | SCL      | GPIO 22*   |

*If conflict, use GPIO 33 (SDA) and GPIO 32 (SCL)

## Important Notes

1. **I2C Address**: Default LCD I2C address is usually 0x27 or 0x3F. Run an I2C scanner if LCD doesn't work.

2. **Power Considerations**:
   - Total current draw: ~300-500mA (ESP32: ~160mA, LCD: ~50mA, Sensors: ~15mA each)
   - 18650 batteries (2500mAh typical) will last 5-8 hours of continuous operation
   - Add a power switch between batteries and step-down for easy on/off

3. **Battery Safety**:
   - Use protected 18650 cells
   - Ensure correct polarity (+ to +, - to -)
   - Never short circuit the batteries
   - Charge batteries with appropriate charger (4.2V max per cell)

4. **Detection Distance**:
   - Ultrasonic sensors work best between 2cm - 400cm
   - Mount sensors 15-20cm above ground
   - Set threshold distance to 10-15cm for vehicle detection

5. **Wiring Tips**:
   - Use solid core wires for breadboard prototyping
   - Use stranded wires for final assembly
   - Keep sensor wiring short (<30cm) for accurate readings
   - Add a 100µF capacitor near ESP32 VIN for stable power

## Troubleshooting

**LCD not displaying:**
- Check I2C address (use I2C scanner sketch)
- Verify SDA/SCL connections
- Adjust LCD contrast potentiometer

**Sensors not detecting:**
- Check 5V power supply
- Verify TRIG/ECHO connections
- Ensure sensors face parking slots
- Check for physical obstructions

**ESP32 not connecting to WiFi:**
- Verify WiFi credentials
- Check antenna (if external)
- Ensure adequate power supply
- Reset ESP32

**System resets randomly:**
- Insufficient power - check step-down output
- Add capacitor to power rail
- Reduce WiFi transmission power in code
