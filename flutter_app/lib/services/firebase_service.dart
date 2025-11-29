import 'package:firebase_database/firebase_database.dart';
import '../models/parking_slot.dart';
import '../models/parking_summary.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Get real-time parking slots data
  Stream<List<ParkingSlot>> getParkingSlots() {
    return _database.child('parking/slots').onValue.map((event) {
      final List<ParkingSlot> slots = [];

      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          if (value is Map) {
            slots.add(ParkingSlot.fromMap(key, value));
          }
        });
      }

      // Sort slots by name
      slots.sort((a, b) => a.name.compareTo(b.name));

      return slots;
    });
  }

  // Get real-time parking summary
  Stream<ParkingSummary?> getParkingSummary() {
    return _database.child('parking/summary').onValue.map((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        return ParkingSummary.fromMap(data);
      }
      return null;
    });
  }

  // Get system status
  Stream<String> getSystemStatus() {
    return _database.child('parking/system/status').onValue.map((event) {
      return event.snapshot.value?.toString() ?? 'offline';
    });
  }

  // Get system name
  Future<String> getSystemName() async {
    final snapshot = await _database.child('parking/system/name').get();
    return snapshot.value?.toString() ?? 'Smart Parking';
  }

  // Get system location
  Future<String> getSystemLocation() async {
    final snapshot = await _database.child('parking/system/location').get();
    return snapshot.value?.toString() ?? 'Unknown Location';
  }
}
