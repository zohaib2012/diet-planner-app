import 'package:flutter/material.dart';
import '../models/water_log.dart';
import '../utils/helpers.dart';
import 'package:uuid/uuid.dart';

class WaterProvider with ChangeNotifier {
  final List<WaterLog> _waterLogs = [];
  int _goalGlasses = 8;
  int _glassSizeMl = 250;

  int get goalGlasses => _goalGlasses;
  int get glassSizeMl => _glassSizeMl;

  WaterLog getTodayLog() {
    final today = DateTime.now();
    final log = _waterLogs.where((w) => Helpers.isSameDay(w.date, today)).firstOrNull;
    if (log != null) return log;

    // Create today's log
    final newLog = WaterLog(
      id: const Uuid().v4(),
      date: today,
      glassCount: 0,
      goalGlasses: _goalGlasses,
      glassSizeMl: _glassSizeMl,
    );
    _waterLogs.add(newLog);
    return newLog;
  }

  void addGlass() {
    final log = getTodayLog();
    log.glassCount++;
    notifyListeners();
  }

  void removeGlass() {
    final log = getTodayLog();
    if (log.glassCount > 0) {
      log.glassCount--;
      notifyListeners();
    }
  }

  void setGoalGlasses(int goal) {
    _goalGlasses = goal;
    notifyListeners();
  }

  void setGlassSize(int sizeMl) {
    _glassSizeMl = sizeMl;
    notifyListeners();
  }

  // Get water history for last N days
  List<WaterLog> getWeekHistory() {
    List<WaterLog> history = [];
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final log = _waterLogs.where((w) => Helpers.isSameDay(w.date, date)).firstOrNull;
      history.add(log ?? WaterLog(
        id: 'temp_$i',
        date: date,
        glassCount: 0,
        goalGlasses: _goalGlasses,
        glassSizeMl: _glassSizeMl,
      ));
    }
    return history;
  }
}
