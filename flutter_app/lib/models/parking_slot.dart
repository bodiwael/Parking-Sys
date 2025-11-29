class ParkingSlot {
  final String id;
  final String name;
  final bool occupied;

  ParkingSlot({
    required this.id,
    required this.name,
    required this.occupied,
  });

  factory ParkingSlot.fromMap(String id, Map<dynamic, dynamic> map) {
    return ParkingSlot(
      id: id,
      name: map['name'] ?? 'Unknown',
      occupied: map['occupied'] ?? false,
    );
  }

  bool get isAvailable => !occupied;
}
