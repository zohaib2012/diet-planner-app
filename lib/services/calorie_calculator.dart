class CalorieCalculator {
  static double calculateBMR({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    if (gender == 'male') {
      return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
  }

  static double getActivityMultiplier(String activityLevel) {
    switch (activityLevel) {
      case 'sedentary':
        return 1.2;
      case 'light':
        return 1.375;
      case 'moderate':
        return 1.55;
      case 'active':
        return 1.725;
      case 'very_active':
        return 1.9;
      default:
        return 1.55;
    }
  }

  static double calculateTDEE({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
    required String activityLevel,
  }) {
    double bmr = calculateBMR(
      gender: gender,
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
    );
    return bmr * getActivityMultiplier(activityLevel);
  }

  static double calculateGoalCalories({
    required double tdee,
    required String goal,
  }) {
    switch (goal) {
      case 'lose':
        return tdee - 500;
      case 'gain':
        return tdee + 500;
      default:
        return tdee;
    }
  }

  static Map<String, double> calculateMacros(double dailyCalories) {
    return {
      'protein': (dailyCalories * 0.30) / 4,
      'carbs': (dailyCalories * 0.45) / 4,
      'fat': (dailyCalories * 0.25) / 9,
    };
  }

  static double calculateBMI({
    required double weightKg,
    required double heightCm,
  }) {
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}
