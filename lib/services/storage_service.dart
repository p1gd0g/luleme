import 'package:hive_flutter/hive_flutter.dart';
import '../models/event_record.dart';

class StorageService {
  static const String _boxName = 'events';
  late Box<EventRecord> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EventRecordAdapter());
    _box = await Hive.openBox<EventRecord>(_boxName);
  }

  Future<void> addEvent(EventRecord event) async {
    await _box.add(event);
  }

  List<EventRecord> getAllEvents() {
    return _box.values.toList();
  }

  List<EventRecord> getEventsInRange(DateTime start, DateTime end) {
    return _box.values
        .where((event) =>
            event.timestamp.isAfter(start.subtract(const Duration(days: 1))) &&
            event.timestamp.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }

  Future<void> deleteEvent(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> updateEvent(int index, EventRecord event) async {
    await _box.putAt(index, event);
  }

  int getTotalCount() {
    return _box.length;
  }

  void dispose() {
    _box.close();
  }
}
