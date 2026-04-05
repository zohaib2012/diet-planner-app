import 'package:flutter/material.dart';
import '../models/weight_log.dart';
import '../services/calorie_calculator.dart';
import 'package:uuid/uuid.dart';

class ProgressProvider with ChangeNotifier {
  final List<WeightLog> _weightLogs = [];

  List<WeightLog> get weightLogs => List.from(_weightLogs)..sort((a, b) => a.date.compareTo(b.date));

  void addWeightLog(double weight, double heightCm) {
    final bmi = CalorieCalculator.calculateBMI(weightKg: weight, heightCm: heightCm);
    final log = WeightLog(
      id: const Uuid().v4(),
      date: DateTime.now(),
      weightKg: weight,
      bmi: bmi,
    );
    // Remove existing log for today if any
    _weightLogs.removeWhere((w) =>
      w.date.year == log.date.year &&
      w.date.month == log.date.month &&
      w.date.day == log.date.day
    );
    _weightLogs.add(log);
    notifyListeners();
  }

  void deleteWeightLog(String id) {
    _weightLogs.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  // Get weight history for last N days
  List<WeightLog> getWeightHistory(int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return weightLogs.where((w) => w.date.isAfter(cutoff)).toList();
  }

  // Get latest weight
  double? get latestWeight {
    if (_weightLogs.isEmpty) return null;
    return weightLogs.last.weightKg;
  }

  // Get latest BMI
  double? get latestBMI {
    if (_weightLogs.isEmpty) return null;
    return weightLogs.last.bmi;
  }

  // Weight change from first to last
  double? get weightChange {
    if (_weightLogs.length < 2) return null;
    final sorted = weightLogs;
    return sorted.last.weightKg - sorted.first.weightKg;
  }
}
