class AppRoutes {
  // Onboarding & Auth
  static const splash = '/';
  static const walkthrough = '/walkthrough';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';

  // Profile Setup
  static const personalInfo = '/profile/personal-info';
  static const goalSelection = '/profile/goal';
  static const activityLevel = '/profile/activity';
  static const dietaryPreference = '/profile/dietary';
  static const tdeeResult = '/profile/tdee-result';

  // Main App
  static const dashboard = '/dashboard';

  // Meal Screens
  static const searchFood = '/meals/search';
  static const addMeal = '/meals/add';
  static const mealDetail = '/meals/detail';
  static const editMeal = '/meals/edit';
  static const dailyMealLog = '/meals/daily';
  static const favoriteFoods = '/meals/favorites';

  // Water
  static const waterTracker = '/water';
  static const waterHistory = '/water/history';

  // Recipe Screens
  static const recipeList = '/recipes';
  static const recipeDetail = '/recipes/detail';
  static const addRecipe = '/recipes/add';
  static const editRecipe = '/recipes/edit';
  static const cookingSteps = '/recipes/steps';

  // Diet Plan
  static const choosePlan = '/diet-plan/choose';
  static const weeklyPlan = '/diet-plan/weekly';
  static const dayDetail = '/diet-plan/day';
  static const groceryList = '/diet-plan/grocery';

  // Progress
  static const weightLog = '/progress/weight-log';
  static const weightGraph = '/progress/weight-graph';
  static const bmiCalculator = '/progress/bmi';
  static const calorieHistory = '/progress/calorie-history';

  // Reminders
  static const reminderList = '/reminders';
  static const addReminder = '/reminders/add';

  // Settings
  static const settings = '/settings';
  static const editProfile = '/settings/edit-profile';
  static const themeSettings = '/settings/theme';
  static const unitSettings = '/settings/units';
  static const aboutHelp = '/settings/about';
}
