import 'package:hive/hive.dart';

part 'event_record.g.dart';

@HiveType(typeId: 0)
class EventRecord extends HiveObject {
  @HiveField(0)
  DateTime timestamp;

  @HiveField(1)
  String? notes;

  @HiveField(2)
  int? rating; // 1-5 rating for feeling/satisfaction

  EventRecord({
    required this.timestamp,
    this.notes,
    this.rating,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'notes': notes,
        'rating': rating,
      };

  factory EventRecord.fromJson(Map<String, dynamic> json) => EventRecord(
        timestamp: DateTime.parse(json['timestamp']),
        notes: json['notes'],
        rating: json['rating'],
      );
}
