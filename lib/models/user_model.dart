class UserModel {
  String id;
  String name;
  String email;
  String password;
  int age;
  String gender;
  double heightCm;
  double weightKg;
  String goal; // lose, maintain, gain
  String activityLevel; // sedentary, light, moderate, active, very_active
  String dietaryPref; // veg, non-veg, vegan, eggetarian
  double dailyCalories;
  double proteinGoal;
  double carbsGoal;
  double fatGoal;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.age = 25,
    this.gender = 'male',
    this.heightCm = 170,
    this.weightKg = 70,
    this.goal = 'maintain',
    this.activityLevel = 'moderate',
    this.dietaryPref = 'non-veg',
    this.dailyCalories = 2000,
    this.proteinGoal = 150,
    this.carbsGoal = 225,
    this.fatGoal = 55,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'goal': goal,
      'activityLevel': activityLevel,
      'dietaryPref': dietaryPref,
      'dailyCalories': dailyCalories,
      'proteinGoal': proteinGoal,
      'carbsGoal': carbsGoal,
      'fatGoal': fatGoal,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      age: map['age'],
      gender: map['gender'],
      heightCm: (map['heightCm'] as num).toDouble(),
      weightKg: (map['weightKg'] as num).toDouble(),
      goal: map['goal'],
      activityLevel: map['activityLevel'],
      dietaryPref: map['dietaryPref'],
      dailyCalories: (map['dailyCalories'] as num).toDouble(),
      proteinGoal: (map['proteinGoal'] as num).toDouble(),
      carbsGoal: (map['carbsGoal'] as num).toDouble(),
      fatGoal: (map['fatGoal'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
