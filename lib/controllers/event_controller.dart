import 'package:get/get.dart';
import '../models/event_model.dart';
import '../services/storage_service.dart';
import 'dart:developer' as developer;

/// Controller for managing tracking events
class EventController extends GetxController {
  final StorageService _storageService = StorageService();
  
  // Observable list of events
  final RxList<EventModel> events = <EventModel>[].obs;
  
  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  /// Load events from storage
  Future<void> loadEvents() async {
    try {
      isLoading.value = true;
      final loadedEvents = await _storageService.loadEvents();
      // Sort by timestamp descending (newest first)
      loadedEvents.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      events.value = loadedEvents;
    } catch (e, s) {
      developer.log(
        'Error loading events in controller',
        name: 'EventController',
        error: e,
        stackTrace: s,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Add a new event
  Future<void> addEvent({
    int? durationMinutes,
    String? feeling,
    String? notes,
  }) async {
    try {
      final newEvent = EventModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        durationMinutes: durationMinutes,
        feeling: feeling,
        notes: notes,
      );

      events.insert(0, newEvent); // Add to beginning (newest first)
      await _storageService.saveEvents(events);
      
      Get.snackbar(
        '记录成功',
        '已添加新记录',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      
      developer.log('Added new event: ${newEvent.id}', name: 'EventController');
    } catch (e, s) {
      developer.log(
        'Error adding event',
        name: 'EventController',
        error: e,
        stackTrace: s,
      );
      Get.snackbar(
        '错误',
        '添加记录失败',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Delete an event
  Future<void> deleteEvent(String id) async {
    try {
      events.removeWhere((event) => event.id == id);
      await _storageService.saveEvents(events);
      
      Get.snackbar(
        '删除成功',
        '记录已删除',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      
      developer.log('Deleted event: $id', name: 'EventController');
    } catch (e, s) {
      developer.log(
        'Error deleting event',
        name: 'EventController',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Update an event
  Future<void> updateEvent(EventModel updatedEvent) async {
    try {
      final index = events.indexWhere((e) => e.id == updatedEvent.id);
      if (index != -1) {
        events[index] = updatedEvent;
        await _storageService.saveEvents(events);
        
        developer.log('Updated event: ${updatedEvent.id}', name: 'EventController');
      }
    } catch (e, s) {
      developer.log(
        'Error updating event',
        name: 'EventController',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Get events for a specific date range
  List<EventModel> getEventsInRange(DateTime start, DateTime end) {
    return events.where((event) {
      return event.timestamp.isAfter(start) && event.timestamp.isBefore(end);
    }).toList();
  }

  /// Get events for the current week
  List<EventModel> getWeeklyEvents() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endDate = startDate.add(const Duration(days: 7));
    return getEventsInRange(startDate, endDate);
  }

  /// Get events for the current month
  List<EventModel> getMonthlyEvents() {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = DateTime(now.year, now.month + 1, 1);
    return getEventsInRange(startDate, endDate);
  }

  /// Get total count of events
  int get totalCount => events.length;

  /// Get weekly count
  int get weeklyCount => getWeeklyEvents().length;

  /// Get monthly count
  int get monthlyCount => getMonthlyEvents().length;

  /// Clear all events (for testing)
  Future<void> clearAllEvents() async {
    try {
      events.clear();
      await _storageService.clearEvents();
      
      Get.snackbar(
        '清除成功',
        '所有记录已清除',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, s) {
      developer.log(
        'Error clearing events',
        name: 'EventController',
        error: e,
        stackTrace: s,
      );
    }
  }
}
