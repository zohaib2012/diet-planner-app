import 'package:flutter/material.dart';
import '../models/diet_plan.dart';
import '../utils/seed_data.dart';

class DietPlanProvider with ChangeNotifier {
  List<DietPlan> _plans = [];
  DietPlan? _activePlan;

  List<DietPlan> get plans => _plans;
  DietPlan? get activePlan => _activePlan;

  void init() {
    if (_plans.isEmpty) {
      _plans = SeedData.getDietPlans();
    }
  }

  void selectPlan(String planId) {
    for (var plan in _plans) {
      plan.isActive = plan.id == planId;
    }
    _activePlan = _plans.where((p) => p.id == planId).firstOrNull;
    notifyListeners();
  }

  DayPlan? getDayPlan(String dayName) {
    if (_activePlan == null) return null;
    return _activePlan!.days.where((d) => d.dayName == dayName).firstOrNull;
  }

  // Generate grocery list from active plan
  List<String> generateGroceryList() {
    if (_activePlan == null) return [];

    Set<String> items = {};
    for (var day in _activePlan!.days) {
      for (var meal in day.meals) {
        items.add(meal.recipeName);
      }
    }

    // Simple grocery list based on recipe names
    List<String> grocery = [];
    for (var recipe in items) {
      grocery.add('Ingredients for $recipe');
    }
    grocery.sort();
    return grocery;
  }
}
