import 'package:flutter/material.dart';
import '../models/reminder_model.dart';
import '../utils/seed_data.dart';
import 'package:uuid/uuid.dart';

class ReminderProvider with ChangeNotifier {
  List<ReminderModel> _reminders = [];

  List<ReminderModel> get reminders => _reminders;

  void init() {
    if (_reminders.isEmpty) {
      _reminders = SeedData.getDefaultReminders();
    }
  }

  void addReminder(ReminderModel reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void updateReminder(String id, ReminderModel updated) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      _reminders[index] = updated;
      notifyListeners();
    }
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void toggleReminder(String id) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      _reminders[index].isActive = !_reminders[index].isActive;
      notifyListeners();
    }
  }

  ReminderModel createReminder({
    required String title,
    required String type,
    required int hour,
    required int minute,
    required List<int> repeatDays,
  }) {
    return ReminderModel(
      id: const Uuid().v4(),
      title: title,
      type: type,
      hour: hour,
      minute: minute,
      repeatDays: repeatDays,
    );
  }
}
