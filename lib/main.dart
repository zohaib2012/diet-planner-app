import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/auth_provider.dart';
import 'providers/meal_provider.dart';
import 'providers/water_provider.dart';
import 'providers/recipe_provider.dart';
import 'providers/diet_plan_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/reminder_provider.dart';
import 'providers/theme_provider.dart';

// Theme & Routes
import 'theme/app_theme.dart';
import 'utils/app_routes.dart';

// Screens - Onboarding
import 'screens/onboarding/splash_screen.dart';
import 'screens/onboarding/walkthrough_screen.dart';

// Screens - Auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';

// Screens - Profile Setup
import 'screens/profile/personal_info_screen.dart';
import 'screens/profile/goal_selection_screen.dart';
import 'screens/profile/activity_level_screen.dart';
import 'screens/profile/dietary_preference_screen.dart';
import 'screens/profile/tdee_result_screen.dart';

// Screens - Dashboard
import 'screens/dashboard/dashboard_screen.dart';

// Screens - Meals
import 'screens/meals/search_food_screen.dart';
import 'screens/meals/add_meal_screen.dart';
import 'screens/meals/meal_detail_screen.dart';
import 'screens/meals/edit_meal_screen.dart';
import 'screens/meals/daily_meal_log_screen.dart';
import 'screens/meals/favorite_foods_screen.dart';

// Screens - Water
import 'screens/water/water_tracker_screen.dart';
import 'screens/water/water_history_screen.dart';

// Screens - Recipes
import 'screens/recipes/recipe_list_screen.dart';
import 'screens/recipes/recipe_detail_screen.dart';
import 'screens/recipes/add_recipe_screen.dart';
import 'screens/recipes/edit_recipe_screen.dart';
import 'screens/recipes/cooking_steps_screen.dart';

// Screens - Diet Plan
import 'screens/diet_plan/choose_plan_screen.dart';
import 'screens/diet_plan/weekly_plan_screen.dart';
import 'screens/diet_plan/day_detail_screen.dart';
import 'screens/diet_plan/grocery_list_screen.dart';

// Screens - Progress
import 'screens/progress/weight_log_screen.dart';
import 'screens/progress/weight_graph_screen.dart';
import 'screens/progress/bmi_calculator_screen.dart';
import 'screens/progress/calorie_history_screen.dart';

// Screens - Reminders
import 'screens/reminders/reminder_list_screen.dart';
import 'screens/reminders/add_reminder_screen.dart';

// Screens - Settings
import 'screens/settings/settings_screen.dart';
import 'screens/settings/edit_profile_screen.dart';
import 'screens/settings/theme_settings_screen.dart';
import 'screens/settings/unit_settings_screen.dart';
import 'screens/settings/about_help_screen.dart';

void main() {
  runApp(const DietPlannerApp());
}

class DietPlannerApp extends StatelessWidget {
  const DietPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..init()),
        ChangeNotifierProvider(create: (_) => MealProvider()..init()),
        ChangeNotifierProvider(create: (_) => WaterProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()..init()),
        ChangeNotifierProvider(create: (_) => DietPlanProvider()..init()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()..init()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Diet Planner',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.splash,
            routes: {
              // Onboarding & Auth
              AppRoutes.splash: (_) => SplashScreen(),
              AppRoutes.walkthrough: (_) => WalkthroughScreen(),
              AppRoutes.login: (_) => LoginScreen(),
              AppRoutes.signup: (_) => SignupScreen(),
              AppRoutes.forgotPassword: (_) => ForgotPasswordScreen(),

              // Profile Setup
              AppRoutes.personalInfo: (_) => PersonalInfoScreen(),
              AppRoutes.goalSelection: (_) => GoalSelectionScreen(),
              AppRoutes.activityLevel: (_) => ActivityLevelScreen(),
              AppRoutes.dietaryPreference: (_) => DietaryPreferenceScreen(),
              AppRoutes.tdeeResult: (_) => TdeeResultScreen(),

              // Dashboard
              AppRoutes.dashboard: (_) => DashboardScreen(),

              // Meals
              AppRoutes.searchFood: (_) => SearchFoodScreen(),
              AppRoutes.addMeal: (_) => AddMealScreen(),
              AppRoutes.mealDetail: (_) => MealDetailScreen(),
              AppRoutes.editMeal: (_) => EditMealScreen(),
              AppRoutes.dailyMealLog: (_) => DailyMealLogScreen(),
              AppRoutes.favoriteFoods: (_) => FavoriteFoodsScreen(),

              // Water
              AppRoutes.waterTracker: (_) => WaterTrackerScreen(),
              AppRoutes.waterHistory: (_) => WaterHistoryScreen(),

              // Recipes
              AppRoutes.recipeList: (_) => RecipeListScreen(),
              AppRoutes.recipeDetail: (_) => RecipeDetailScreen(),
              AppRoutes.addRecipe: (_) => AddRecipeScreen(),
              AppRoutes.editRecipe: (_) => EditRecipeScreen(),
              AppRoutes.cookingSteps: (_) => CookingStepsScreen(),

              // Diet Plan
              AppRoutes.choosePlan: (_) => ChoosePlanScreen(),
              AppRoutes.weeklyPlan: (_) => WeeklyPlanScreen(),
              AppRoutes.dayDetail: (_) => DayDetailScreen(),
              AppRoutes.groceryList: (_) => GroceryListScreen(),

              // Progress
              AppRoutes.weightLog: (_) => WeightLogScreen(),
              AppRoutes.weightGraph: (_) => WeightGraphScreen(),
              AppRoutes.bmiCalculator: (_) => BmiCalculatorScreen(),
              AppRoutes.calorieHistory: (_) => CalorieHistoryScreen(),

              // Reminders
              AppRoutes.reminderList: (_) => ReminderListScreen(),
              AppRoutes.addReminder: (_) => AddReminderScreen(),

              // Settings
              AppRoutes.settings: (_) => SettingsScreen(),
              AppRoutes.editProfile: (_) => EditProfileScreen(),
              AppRoutes.themeSettings: (_) => ThemeSettingsScreen(),
              AppRoutes.unitSettings: (_) => UnitSettingsScreen(),
              AppRoutes.aboutHelp: (_) => AboutHelpScreen(),
            },
          );
        },
      ),
    );
  }
}
