import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/diet_plan_provider.dart';
import '../../models/diet_plan.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';

class WeeklyPlanScreen extends StatelessWidget {
  const WeeklyPlanScreen({super.key});

  static const _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  static const _dayTabs = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DietPlanProvider>(context);
    final activePlan = provider.activePlan;

    if (activePlan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Weekly Plan')),
        body: const Center(child: Text('No active plan selected.')),
      );
    }

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(activePlan.planName),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: _dayTabs.map((d) => Tab(text: d)).toList(),
          ),
        ),
        body: TabBarView(
          children: _days.map((dayName) {
            final dayPlan = provider.getDayPlan(dayName);
            if (dayPlan == null) {
              return const Center(child: Text('No plan for this day'));
            }
            return _DayMealList(dayPlan: dayPlan);
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.accent,
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          label: const Text('Grocery List', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.groceryList),
        ),
      ),
    );
  }
}

class _DayMealList extends StatelessWidget {
  final DayPlan dayPlan;

  const _DayMealList({required this.dayPlan});

  IconData _mealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dayPlan.meals.length,
            itemBuilder: (context, index) {
              final meal = dayPlan.meals[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(_mealIcon(meal.mealType), color: AppColors.primaryDark),
                  ),
                  title: Text(
                    meal.recipeName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(meal.mealType),
                  trailing: Text(
                    '${meal.calories.toInt()} kcal',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.dayDetail,
                    arguments: dayPlan,
                  ),
                ),
              );
            },
          ),
        ),

        // Total calories bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          color: AppColors.primaryLight,
          child: Text(
            'Total: ${dayPlan.totalCalories.toInt()} kcal',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
