import 'package:get/get.dart';
import '../models/event_record.dart';
import '../services/storage_service.dart';

class EventController extends GetxController {
  final StorageService _storage = StorageService();
  final RxList<EventRecord> events = <EventRecord>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initStorage();
  }

  Future<void> initStorage() async {
    try {
      isLoading.value = true;
      await _storage.init();
      loadEvents();
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize storage: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadEvents() {
    events.value = _storage.getAllEvents();
  }

  Future<void> addEvent({String? notes, int? rating}) async {
    try {
      final event = EventRecord(
        timestamp: DateTime.now(),
        notes: notes,
        rating: rating,
      );
      await _storage.addEvent(event);
      loadEvents();
      Get.snackbar('Success', 'Event recorded successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add event: $e');
    }
  }

  Future<void> deleteEvent(int index) async {
    try {
      await _storage.deleteEvent(index);
      loadEvents();
      Get.snackbar('Success', 'Event deleted',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete event: $e');
    }
  }

  // Get statistics
  int getTotalCount() => events.length;

  int getWeeklyCount() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return events
        .where((e) => e.timestamp.isAfter(weekStart))
        .length;
  }

  int getMonthlyCount() {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return events
        .where((e) => e.timestamp.isAfter(monthStart))
        .length;
  }

  List<EventRecord> getEventsForLastDays(int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return events.where((e) => e.timestamp.isAfter(cutoff)).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Map<int, int> getWeeklyStats() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: 6));
    
    Map<int, int> stats = {};
    for (int i = 0; i < 7; i++) {
      stats[i] = 0;
    }

    for (var event in events) {
      if (event.timestamp.isAfter(weekStart)) {
        final dayIndex = event.timestamp.difference(weekStart).inDays;
        if (dayIndex >= 0 && dayIndex < 7) {
          stats[dayIndex] = (stats[dayIndex] ?? 0) + 1;
        }
      }
    }
    
    return stats;
  }

  Map<int, int> getMonthlyStats() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    
    Map<int, int> stats = {};
    for (int i = 1; i <= daysInMonth; i++) {
      stats[i] = 0;
    }

    for (var event in events) {
      if (event.timestamp.year == now.year && 
          event.timestamp.month == now.month) {
        final day = event.timestamp.day;
        stats[day] = (stats[day] ?? 0) + 1;
      }
    }
    
    return stats;
  }

  @override
  void onClose() {
    _storage.dispose();
    super.onClose();
  }
}
