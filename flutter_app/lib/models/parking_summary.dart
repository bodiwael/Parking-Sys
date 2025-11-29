class ParkingSummary {
  final int totalSlots;
  final int availableSlots;
  final int occupiedSlots;
  final int lastUpdate;

  ParkingSummary({
    required this.totalSlots,
    required this.availableSlots,
    required this.occupiedSlots,
    required this.lastUpdate,
  });

  factory ParkingSummary.fromMap(Map<dynamic, dynamic> map) {
    return ParkingSummary(
      totalSlots: map['totalSlots'] ?? 0,
      availableSlots: map['availableSlots'] ?? 0,
      occupiedSlots: map['occupiedSlots'] ?? 0,
      lastUpdate: map['lastUpdate'] ?? 0,
    );
  }

  double get occupancyRate {
    if (totalSlots == 0) return 0.0;
    return (occupiedSlots / totalSlots) * 100;
  }

  bool get isFull => availableSlots == 0;
}
