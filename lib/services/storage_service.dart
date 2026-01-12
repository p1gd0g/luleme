import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event_model.dart';
import 'dart:developer' as developer;

/// Service for storing and retrieving tracking events
class StorageService {
  static const String _eventsKey = 'tracking_events';
  
  /// Save a list of events
  Future<void> saveEvents(List<EventModel> events) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = events.map((e) => e.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await prefs.setString(_eventsKey, jsonString);
      developer.log('Saved ${events.length} events', name: 'StorageService');
    } catch (e, s) {
      developer.log(
        'Error saving events',
        name: 'StorageService',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Load all events
  Future<List<EventModel>> loadEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_eventsKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        developer.log('No events found in storage', name: 'StorageService');
        return [];
      }

      final jsonList = json.decode(jsonString) as List;
      final events = jsonList
          .map((json) => EventModel.fromJson(json as Map<String, dynamic>))
          .toList();
      
      developer.log('Loaded ${events.length} events', name: 'StorageService');
      return events;
    } catch (e, s) {
      developer.log(
        'Error loading events',
        name: 'StorageService',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  /// Clear all events (for testing or reset)
  Future<void> clearEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_eventsKey);
      developer.log('Cleared all events', name: 'StorageService');
    } catch (e, s) {
      developer.log(
        'Error clearing events',
        name: 'StorageService',
        error: e,
        stackTrace: s,
      );
    }
  }
}
