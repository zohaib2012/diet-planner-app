class MealLog {
  String id;
  String foodName;
  double calories;
  double protein;
  double carbs;
  double fat;
  double quantity;
  String mealType; // breakfast, lunch, dinner, snack
  DateTime date;

  MealLog({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.quantity = 1,
    required this.mealType,
    required this.date,
  });

  double get totalCalories => calories * quantity;
  double get totalProtein => protein * quantity;
  double get totalCarbs => carbs * quantity;
  double get totalFat => fat * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodName': foodName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'quantity': quantity,
      'mealType': mealType,
      'date': date.toIso8601String(),
    };
  }

  factory MealLog.fromMap(Map<String, dynamic> map) {
    return MealLog(
      id: map['id'],
      foodName: map['foodName'],
      calories: (map['calories'] as num).toDouble(),
      protein: (map['protein'] as num).toDouble(),
      carbs: (map['carbs'] as num).toDouble(),
      fat: (map['fat'] as num).toDouble(),
      quantity: (map['quantity'] as num).toDouble(),
      mealType: map['mealType'],
      date: DateTime.parse(map['date']),
    );
  }
}
