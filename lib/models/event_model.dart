/// Model representing a tracking event
class EventModel {
  final String id;
  final DateTime timestamp;
  final int? durationMinutes; // Optional duration in minutes
  final String? feeling; // Optional feeling/mood (e.g., "relaxed", "stressed", etc.)
  final String? notes; // Optional notes

  EventModel({
    required this.id,
    required this.timestamp,
    this.durationMinutes,
    this.feeling,
    this.notes,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'durationMinutes': durationMinutes,
      'feeling': feeling,
      'notes': notes,
    };
  }

  /// Create from JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      durationMinutes: json['durationMinutes'] as int?,
      feeling: json['feeling'] as String?,
      notes: json['notes'] as String?,
    );
  }

  /// Create a copy with modified fields
  EventModel copyWith({
    String? id,
    DateTime? timestamp,
    int? durationMinutes,
    String? feeling,
    String? notes,
  }) {
    return EventModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      feeling: feeling ?? this.feeling,
      notes: notes ?? this.notes,
    );
  }
}
