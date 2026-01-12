import 'package:flutter_test/flutter_test.dart';
import 'package:luleme/models/event_model.dart';

void main() {
  group('EventModel', () {
    test('creates event with required fields', () {
      final timestamp = DateTime.now();
      final event = EventModel(
        id: '123',
        timestamp: timestamp,
      );

      expect(event.id, '123');
      expect(event.timestamp, timestamp);
      expect(event.durationMinutes, isNull);
      expect(event.feeling, isNull);
      expect(event.notes, isNull);
    });

    test('creates event with all fields', () {
      final timestamp = DateTime.now();
      final event = EventModel(
        id: '456',
        timestamp: timestamp,
        durationMinutes: 15,
        feeling: '放松',
        notes: 'Test note',
      );

      expect(event.id, '456');
      expect(event.timestamp, timestamp);
      expect(event.durationMinutes, 15);
      expect(event.feeling, '放松');
      expect(event.notes, 'Test note');
    });

    test('converts to JSON correctly', () {
      final timestamp = DateTime(2024, 1, 15, 10, 30);
      final event = EventModel(
        id: '789',
        timestamp: timestamp,
        durationMinutes: 20,
        feeling: '愉悦',
        notes: 'Test',
      );

      final json = event.toJson();

      expect(json['id'], '789');
      expect(json['timestamp'], timestamp.toIso8601String());
      expect(json['durationMinutes'], 20);
      expect(json['feeling'], '愉悦');
      expect(json['notes'], 'Test');
    });

    test('creates from JSON correctly', () {
      final timestamp = DateTime(2024, 1, 15, 10, 30);
      final json = {
        'id': '999',
        'timestamp': timestamp.toIso8601String(),
        'durationMinutes': 25,
        'feeling': '正常',
        'notes': 'From JSON',
      };

      final event = EventModel.fromJson(json);

      expect(event.id, '999');
      expect(event.timestamp, timestamp);
      expect(event.durationMinutes, 25);
      expect(event.feeling, '正常');
      expect(event.notes, 'From JSON');
    });

    test('copyWith creates modified copy', () {
      final timestamp = DateTime.now();
      final original = EventModel(
        id: '111',
        timestamp: timestamp,
        durationMinutes: 10,
        feeling: '放松',
        notes: 'Original',
      );

      final modified = original.copyWith(
        durationMinutes: 15,
        notes: 'Modified',
      );

      expect(modified.id, '111');
      expect(modified.timestamp, timestamp);
      expect(modified.durationMinutes, 15);
      expect(modified.feeling, '放松');
      expect(modified.notes, 'Modified');
    });

    test('JSON round-trip maintains data integrity', () {
      final timestamp = DateTime.now();
      final original = EventModel(
        id: '222',
        timestamp: timestamp,
        durationMinutes: 30,
        feeling: '压力',
        notes: 'Round trip test',
      );

      final json = original.toJson();
      final restored = EventModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.timestamp.toIso8601String(), original.timestamp.toIso8601String());
      expect(restored.durationMinutes, original.durationMinutes);
      expect(restored.feeling, original.feeling);
      expect(restored.notes, original.notes);
    });
  });
}
