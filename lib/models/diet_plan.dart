class DietPlan {
  String id;
  String planName;
  String description;
  List<DayPlan> days;
  bool isActive;

  DietPlan({
    required this.id,
    required this.planName,
    required this.description,
    required this.days,
    this.isActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'planName': planName,
      'description': description,
      'days': days.map((d) => d.toMap()).toList(),
      'isActive': isActive,
    };
  }

  factory DietPlan.fromMap(Map<String, dynamic> map) {
    return DietPlan(
      id: map['id'],
      planName: map['planName'],
      description: map['description'],
      days: (map['days'] as List).map((d) => DayPlan.fromMap(d)).toList(),
      isActive: map['isActive'] ?? false,
    );
  }
}

class DayPlan {
  String dayName;
  List<PlanMeal> meals;

  DayPlan({required this.dayName, required this.meals});

  double get totalCalories => meals.fold(0, (sum, m) => sum + m.calories);

  Map<String, dynamic> toMap() {
    return {
      'dayName': dayName,
      'meals': meals.map((m) => m.toMap()).toList(),
    };
  }

  factory DayPlan.fromMap(Map<String, dynamic> map) {
    return DayPlan(
      dayName: map['dayName'],
      meals: (map['meals'] as List).map((m) => PlanMeal.fromMap(m)).toList(),
    );
  }
}

class PlanMeal {
  String mealType;
  String recipeName;
  double calories;
  double protein;
  double carbs;
  double fat;

  PlanMeal({
    required this.mealType,
    required this.recipeName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType,
      'recipeName': recipeName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  factory PlanMeal.fromMap(Map<String, dynamic> map) {
    return PlanMeal(
      mealType: map['mealType'],
      recipeName: map['recipeName'],
      calories: (map['calories'] as num).toDouble(),
      protein: (map['protein'] as num).toDouble(),
      carbs: (map['carbs'] as num).toDouble(),
      fat: (map['fat'] as num).toDouble(),
    );
  }
}
