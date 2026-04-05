import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/calorie_calculator.dart';
import 'package:uuid/uuid.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  final List<UserModel> _users = [];
  bool _isLoggedIn = false;
  bool _isFirstTime = true;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isFirstTime => _isFirstTime;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? true;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (_isLoggedIn) {
      final userId = prefs.getString('currentUserId');
      final name = prefs.getString('userName') ?? '';
      final email = prefs.getString('userEmail') ?? '';
      if (userId != null) {
        _currentUser = UserModel(
          id: userId,
          name: name,
          email: email,
          password: '',
          age: prefs.getInt('userAge') ?? 25,
          gender: prefs.getString('userGender') ?? 'male',
          heightCm: prefs.getDouble('userHeight') ?? 170,
          weightKg: prefs.getDouble('userWeight') ?? 70,
          goal: prefs.getString('userGoal') ?? 'maintain',
          activityLevel: prefs.getString('userActivity') ?? 'moderate',
          dietaryPref: prefs.getString('userDiet') ?? 'non-veg',
          dailyCalories: prefs.getDouble('userCalories') ?? 2000,
          proteinGoal: prefs.getDouble('userProtein') ?? 150,
          carbsGoal: prefs.getDouble('userCarbs') ?? 225,
          fatGoal: prefs.getDouble('userFat') ?? 55,
        );
      }
    }
    notifyListeners();
  }

  Future<bool> signup(String name, String email, String password) async {
    // Check if email already exists
    if (_users.any((u) => u.email == email)) return false;

    final user = UserModel(
      id: const Uuid().v4(),
      name: name,
      email: email,
      password: password,
    );
    _users.add(user);
    _currentUser = user;
    _isLoggedIn = true;

    await _saveSession();
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password) async {
    // For demo: accept any login if no users exist, or check stored credentials
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('userEmail');
    final storedPassword = prefs.getString('userPassword');

    if (storedEmail == email && storedPassword == password) {
      _isLoggedIn = true;
      await init();
      notifyListeners();
      return true;
    }

    // Check in-memory users
    final user = _users.where((u) => u.email == email && u.password == password).firstOrNull;
    if (user != null) {
      _currentUser = user;
      _isLoggedIn = true;
      await _saveSession();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    _isFirstTime = false;
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    int? age,
    String? gender,
    double? heightCm,
    double? weightKg,
    String? goal,
    String? activityLevel,
    String? dietaryPref,
  }) async {
    if (_currentUser == null) return;

    if (name != null) _currentUser!.name = name;
    if (age != null) _currentUser!.age = age;
    if (gender != null) _currentUser!.gender = gender;
    if (heightCm != null) _currentUser!.heightCm = heightCm;
    if (weightKg != null) _currentUser!.weightKg = weightKg;
    if (goal != null) _currentUser!.goal = goal;
    if (activityLevel != null) _currentUser!.activityLevel = activityLevel;
    if (dietaryPref != null) _currentUser!.dietaryPref = dietaryPref;

    // Recalculate TDEE
    double tdee = CalorieCalculator.calculateTDEE(
      gender: _currentUser!.gender,
      weightKg: _currentUser!.weightKg,
      heightCm: _currentUser!.heightCm,
      age: _currentUser!.age,
      activityLevel: _currentUser!.activityLevel,
    );
    _currentUser!.dailyCalories = CalorieCalculator.calculateGoalCalories(
      tdee: tdee,
      goal: _currentUser!.goal,
    );
    final macros = CalorieCalculator.calculateMacros(_currentUser!.dailyCalories);
    _currentUser!.proteinGoal = macros['protein']!;
    _currentUser!.carbsGoal = macros['carbs']!;
    _currentUser!.fatGoal = macros['fat']!;

    await _saveSession();
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> _saveSession() async {
    if (_currentUser == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('currentUserId', _currentUser!.id);
    await prefs.setString('userName', _currentUser!.name);
    await prefs.setString('userEmail', _currentUser!.email);
    await prefs.setString('userPassword', _currentUser!.password);
    await prefs.setInt('userAge', _currentUser!.age);
    await prefs.setString('userGender', _currentUser!.gender);
    await prefs.setDouble('userHeight', _currentUser!.heightCm);
    await prefs.setDouble('userWeight', _currentUser!.weightKg);
    await prefs.setString('userGoal', _currentUser!.goal);
    await prefs.setString('userActivity', _currentUser!.activityLevel);
    await prefs.setString('userDiet', _currentUser!.dietaryPref);
    await prefs.setDouble('userCalories', _currentUser!.dailyCalories);
    await prefs.setDouble('userProtein', _currentUser!.proteinGoal);
    await prefs.setDouble('userCarbs', _currentUser!.carbsGoal);
    await prefs.setDouble('userFat', _currentUser!.fatGoal);
  }
}
