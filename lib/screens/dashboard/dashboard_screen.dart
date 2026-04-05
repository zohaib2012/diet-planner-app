import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/meal_provider.dart';
import '../../providers/water_provider.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/calorie_ring.dart';
import '../../widgets/macro_progress_bar.dart';
import '../../widgets/section_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MealProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeTab(),
          _MealsTab(),
          _RecipesTab(),
          _ProgressTab(),
          _SettingsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Recipes'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// ─── HOME TAB ───
class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final mealProvider = context.watch<MealProvider>();
    final waterProvider = context.watch<WaterProvider>();
    final totals = mealProvider.getDailyTotals(DateTime.now());
    final waterLog = waterProvider.getTodayLog();

    if (user == null) return Center(child: CircularProgressIndicator());

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, ${user.name.split(' ').first}!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(Helpers.formatDate(DateTime.now()), style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    radius: 22,
                    child: Text(user.name[0].toUpperCase(), style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Calorie Ring
            Center(
              child: CalorieRing(
                consumed: totals['calories']!,
                goal: user.dailyCalories,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Goal: ${user.dailyCalories.toInt()} kcal',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
            SizedBox(height: 20),

            // Macros
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Macros', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      SizedBox(height: 8),
                      MacroProgressBar(label: 'Protein', current: totals['protein']!, goal: user.proteinGoal, color: AppColors.proteinColor),
                      MacroProgressBar(label: 'Carbs', current: totals['carbs']!, goal: user.carbsGoal, color: AppColors.carbsColor),
                      MacroProgressBar(label: 'Fat', current: totals['fat']!, goal: user.fatGoal, color: AppColors.fatColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),

            // Water Tracker
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.water_drop, color: AppColors.waterColor, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Water Intake', style: TextStyle(fontWeight: FontWeight.w600)),
                            Text('${waterLog.glassCount}/${waterLog.goalGlasses} glasses',
                                style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => waterProvider.addGlass(),
                        icon: Icon(Icons.add_circle, color: AppColors.waterColor, size: 32),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.waterTracker),
                        child: Text('More'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),

            // Today's Meals
            SectionHeader(
              title: "Today's Meals",
              actionText: 'View All',
              onAction: () => Navigator.pushNamed(context, AppRoutes.dailyMealLog),
            ),
            ...['breakfast', 'lunch', 'dinner', 'snack'].map((type) {
              final meals = mealProvider.getMealsByType(DateTime.now(), type);
              final total = meals.fold<double>(0, (sum, m) => sum + m.totalCalories);
              return ListTile(
                leading: Icon(
                  type == 'breakfast' ? Icons.free_breakfast :
                  type == 'lunch' ? Icons.lunch_dining :
                  type == 'dinner' ? Icons.dinner_dining : Icons.cookie,
                  color: AppColors.primary,
                ),
                title: Text(type[0].toUpperCase() + type.substring(1)),
                subtitle: Text(meals.isEmpty ? 'Not logged yet' : '${meals.length} items'),
                trailing: Text(
                  meals.isEmpty ? '+ Add' : '${total.toInt()} kcal',
                  style: TextStyle(
                    color: meals.isEmpty ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.searchFood, arguments: type),
              );
            }),
            SizedBox(height: 12),

            // Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _quickAction(context, 'Log Meal', Icons.add_circle, AppColors.primary, () => Navigator.pushNamed(context, AppRoutes.addMeal)),
                  SizedBox(width: 8),
                  _quickAction(context, 'Add Water', Icons.water_drop, AppColors.waterColor, () => waterProvider.addGlass()),
                  SizedBox(width: 8),
                  _quickAction(context, 'Diet Plans', Icons.menu_book, AppColors.accent, () => Navigator.pushNamed(context, AppRoutes.choosePlan)),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              SizedBox(height: 6),
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── PLACEHOLDER TABS (redirect to actual screens) ───
class _MealsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Log')),
      body: _buildMealList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addMeal),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMealList(BuildContext context) {
    final mealProvider = context.watch<MealProvider>();
    final todayMeals = mealProvider.getMealsForDate(DateTime.now());

    if (todayMeals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 64, color: Colors.grey[300]),
            SizedBox(height: 16),
            Text('No meals logged today', style: TextStyle(color: Colors.grey[500], fontSize: 16)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.addMeal),
              child: Text('Log Your First Meal'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(8),
      children: ['breakfast', 'lunch', 'dinner', 'snack'].expand((type) {
        final meals = mealProvider.getMealsByType(DateTime.now(), type);
        if (meals.isEmpty) return <Widget>[];
        return [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(type[0].toUpperCase() + type.substring(1),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.primary)),
          ),
          ...meals.map((meal) => Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            child: ListTile(
              title: Text(meal.foodName, style: TextStyle(fontSize: 14)),
              subtitle: Text('P:${meal.totalProtein.toInt()}g C:${meal.totalCarbs.toInt()}g F:${meal.totalFat.toInt()}g', style: TextStyle(fontSize: 11)),
              trailing: Text('${meal.totalCalories.toInt()} kcal', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              onTap: () => Navigator.pushNamed(context, AppRoutes.mealDetail, arguments: meal),
            ),
          )),
        ];
      }).toList(),
    );
  }
}

class _RecipesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Redirect to recipe list
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: _RecipeListContent(),
    );
  }
}

class _RecipeListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeProvider>().recipes;
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: recipes.length,
      itemBuilder: (context, i) {
        final recipe = recipes[i];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.restaurant_menu, color: AppColors.primaryDark, size: 20),
            ),
            title: Text(recipe.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            subtitle: Text('${recipe.cuisine} | ${recipe.caloriesPerServing.toInt()} kcal', style: TextStyle(fontSize: 12)),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.recipeDetail, arguments: recipe),
          ),
        );
      },
    );
  }
}

class _ProgressTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _progressCard(context, 'Weight Log', 'Track your daily weight', Icons.monitor_weight, AppRoutes.weightLog),
          _progressCard(context, 'Weight Graph', 'Visualize weight over time', Icons.show_chart, AppRoutes.weightGraph),
          _progressCard(context, 'BMI Calculator', 'Check your BMI status', Icons.calculate, AppRoutes.bmiCalculator),
          _progressCard(context, 'Calorie History', 'Daily calorie intake chart', Icons.bar_chart, AppRoutes.calorieHistory),
        ],
      ),
    );
  }

  Widget _progressCard(BuildContext context, String title, String subtitle, IconData icon, String route) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: AppColors.primaryLight, child: Icon(icon, color: AppColors.primary)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
        trailing: Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.person), title: Text('Edit Profile'), onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile)),
          ListTile(leading: Icon(Icons.palette), title: Text('Theme'), onTap: () => Navigator.pushNamed(context, AppRoutes.themeSettings)),
          ListTile(leading: Icon(Icons.straighten), title: Text('Units'), onTap: () => Navigator.pushNamed(context, AppRoutes.unitSettings)),
          ListTile(leading: Icon(Icons.water_drop), title: Text('Water Tracker'), onTap: () => Navigator.pushNamed(context, AppRoutes.waterTracker)),
          ListTile(leading: Icon(Icons.notifications), title: Text('Reminders'), onTap: () => Navigator.pushNamed(context, AppRoutes.reminderList)),
          ListTile(leading: Icon(Icons.food_bank), title: Text('Diet Plans'), onTap: () => Navigator.pushNamed(context, AppRoutes.choosePlan)),
          ListTile(leading: Icon(Icons.info), title: Text('About & Help'), onTap: () => Navigator.pushNamed(context, AppRoutes.aboutHelp)),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.error),
            title: Text('Logout', style: TextStyle(color: AppColors.error)),
            onTap: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
            },
          ),
        ],
      ),
    );
  }
}

