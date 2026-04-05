class Recipe {
  String id;
  String name;
  String cuisine;
  String dietType; // veg, non-veg, vegan
  String mealType; // breakfast, lunch, dinner, snack
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  List<String> ingredients;
  List<String> steps;
  double caloriesPerServing;
  double proteinPerServing;
  double carbsPerServing;
  double fatPerServing;
  bool isCustom;

  Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.dietType,
    required this.mealType,
    this.prepTimeMinutes = 10,
    this.cookTimeMinutes = 20,
    this.servings = 2,
    required this.ingredients,
    required this.steps,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.carbsPerServing,
    required this.fatPerServing,
    this.isCustom = false,
  });

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'dietType': dietType,
      'mealType': mealType,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'ingredients': ingredients,
      'steps': steps,
      'caloriesPerServing': caloriesPerServing,
      'proteinPerServing': proteinPerServing,
      'carbsPerServing': carbsPerServing,
      'fatPerServing': fatPerServing,
      'isCustom': isCustom,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      cuisine: map['cuisine'],
      dietType: map['dietType'],
      mealType: map['mealType'],
      prepTimeMinutes: map['prepTimeMinutes'] ?? 10,
      cookTimeMinutes: map['cookTimeMinutes'] ?? 20,
      servings: map['servings'] ?? 2,
      ingredients: List<String>.from(map['ingredients']),
      steps: List<String>.from(map['steps']),
      caloriesPerServing: (map['caloriesPerServing'] as num).toDouble(),
      proteinPerServing: (map['proteinPerServing'] as num).toDouble(),
      carbsPerServing: (map['carbsPerServing'] as num).toDouble(),
      fatPerServing: (map['fatPerServing'] as num).toDouble(),
      isCustom: map['isCustom'] ?? false,
    );
  }
}
