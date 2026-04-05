import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../utils/seed_data.dart';
import '../utils/helpers.dart';
import 'package:uuid/uuid.dart';

class MealProvider with ChangeNotifier {
  List<FoodItem> _foodItems = [];
  final List<MealLog> _mealLogs = [];

  List<FoodItem> get foodItems => _foodItems;
  List<MealLog> get mealLogs => _mealLogs;

  List<FoodItem> get favoriteFoods => _foodItems.where((f) => f.isFavorite).toList();

  void init() {
    if (_foodItems.isEmpty) {
      _foodItems = SeedData.getFoodItems();
    }
  }

  // Get meals for a specific date
  List<MealLog> getMealsForDate(DateTime date) {
    return _mealLogs.where((m) => Helpers.isSameDay(m.date, date)).toList();
  }

  // Get meals by type for a date
  List<MealLog> getMealsByType(DateTime date, String mealType) {
    return getMealsForDate(date).where((m) => m.mealType == mealType).toList();
  }

  // Daily totals
  Map<String, double> getDailyTotals(DateTime date) {
    final meals = getMealsForDate(date);
    return {
      'calories': meals.fold(0, (sum, m) => sum + m.totalCalories),
      'protein': meals.fold(0, (sum, m) => sum + m.totalProtein),
      'carbs': meals.fold(0, (sum, m) => sum + m.totalCarbs),
      'fat': meals.fold(0, (sum, m) => sum + m.totalFat),
    };
  }

  // Calorie history for last N days
  List<Map<String, dynamic>> getCalorieHistory(int days) {
    List<Map<String, dynamic>> history = [];
    for (int i = days - 1; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final totals = getDailyTotals(date);
      history.add({
        'date': date,
        'calories': totals['calories']!,
      });
    }
    return history;
  }

  // Search foods
  List<FoodItem> searchFoods(String query) {
    if (query.isEmpty) return _foodItems;
    return _foodItems.where((f) =>
      f.name.toLowerCase().contains(query.toLowerCase()) ||
      f.category.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Get foods by category
  List<FoodItem> getFoodsByCategory(String category) {
    if (category == 'All') return _foodItems;
    return _foodItems.where((f) => f.category == category).toList();
  }

  // Get all categories
  List<String> get categories {
    return ['All', ..._foodItems.map((f) => f.category).toSet().toList()];
  }

  // Add meal
  void addMeal(MealLog meal) {
    _mealLogs.add(meal);
    notifyListeners();
  }

  // Quick add from food item
  void addMealFromFood(FoodItem food, String mealType, double quantity) {
    final meal = MealLog(
      id: const Uuid().v4(),
      foodName: food.name,
      calories: food.caloriesPerServing,
      protein: food.proteinPerServing,
      carbs: food.carbsPerServing,
      fat: food.fatPerServing,
      quantity: quantity,
      mealType: mealType,
      date: DateTime.now(),
    );
    _mealLogs.add(meal);
    notifyListeners();
  }

  // Update meal
  void updateMeal(String id, MealLog updatedMeal) {
    final index = _mealLogs.indexWhere((m) => m.id == id);
    if (index != -1) {
      _mealLogs[index] = updatedMeal;
      notifyListeners();
    }
  }

  // Delete meal
  void deleteMeal(String id) {
    _mealLogs.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  // Toggle favorite
  void toggleFavorite(String foodId) {
    final index = _foodItems.indexWhere((f) => f.id == foodId);
    if (index != -1) {
      _foodItems[index].isFavorite = !_foodItems[index].isFavorite;
      notifyListeners();
    }
  }
}
