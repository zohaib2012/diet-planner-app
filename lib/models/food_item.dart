class FoodItem {
  String id;
  String name;
  double caloriesPer100g;
  double proteinPer100g;
  double carbsPer100g;
  double fatPer100g;
  String category;
  String servingUnit;
  double servingSize; // grams per 1 serving
  bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.category,
    this.servingUnit = 'serving',
    this.servingSize = 100,
    this.isFavorite = false,
  });

  double get caloriesPerServing => (caloriesPer100g * servingSize) / 100;
  double get proteinPerServing => (proteinPer100g * servingSize) / 100;
  double get carbsPerServing => (carbsPer100g * servingSize) / 100;
  double get fatPerServing => (fatPer100g * servingSize) / 100;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'caloriesPer100g': caloriesPer100g,
      'proteinPer100g': proteinPer100g,
      'carbsPer100g': carbsPer100g,
      'fatPer100g': fatPer100g,
      'category': category,
      'servingUnit': servingUnit,
      'servingSize': servingSize,
      'isFavorite': isFavorite,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'],
      name: map['name'],
      caloriesPer100g: (map['caloriesPer100g'] as num).toDouble(),
      proteinPer100g: (map['proteinPer100g'] as num).toDouble(),
      carbsPer100g: (map['carbsPer100g'] as num).toDouble(),
      fatPer100g: (map['fatPer100g'] as num).toDouble(),
      category: map['category'],
      servingUnit: map['servingUnit'] ?? 'serving',
      servingSize: (map['servingSize'] as num?)?.toDouble() ?? 100,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
