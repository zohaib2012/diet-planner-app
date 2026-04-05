import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/seed_data.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void init() {
    if (_recipes.isEmpty) {
      _recipes = SeedData.getRecipes();
    }
  }

  // Filter recipes
  List<Recipe> filterRecipes({String? mealType, String? dietType, String? cuisine, String? query}) {
    var filtered = _recipes.toList();

    if (query != null && query.isNotEmpty) {
      filtered = filtered.where((r) =>
        r.name.toLowerCase().contains(query.toLowerCase()) ||
        r.cuisine.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    if (mealType != null && mealType != 'All') {
      filtered = filtered.where((r) => r.mealType == mealType.toLowerCase()).toList();
    }
    if (dietType != null && dietType != 'All') {
      filtered = filtered.where((r) => r.dietType == dietType).toList();
    }
    if (cuisine != null && cuisine != 'All') {
      filtered = filtered.where((r) => r.cuisine == cuisine).toList();
    }
    return filtered;
  }

  List<String> get cuisines {
    return ['All', ..._recipes.map((r) => r.cuisine).toSet().toList()];
  }

  List<String> get dietTypes {
    return ['All', ..._recipes.map((r) => r.dietType).toSet().toList()];
  }

  Recipe? getRecipeById(String id) {
    return _recipes.where((r) => r.id == id).firstOrNull;
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void updateRecipe(String id, Recipe updated) {
    final index = _recipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      _recipes[index] = updated;
      notifyListeners();
    }
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
