import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';
import '../../widgets/meal_card.dart';
import '../../widgets/empty_state_widget.dart';

class DailyMealLogScreen extends StatelessWidget {
  const DailyMealLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = context.watch<MealProvider>();
    final todayMeals = mealProvider.getMealsForDate(DateTime.now());
    final totals = mealProvider.getDailyTotals(DateTime.now());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daily Meal Log'),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Breakfast'),
              Tab(text: 'Lunch'),
              Tab(text: 'Dinner'),
              Tab(text: 'Snack'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Summary bar
            Container(
              padding: EdgeInsets.all(12),
              color: AppColors.primaryLight.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem('Calories', '${totals['calories']!.toInt()}', 'kcal'),
                  _summaryItem('Protein', '${totals['protein']!.toInt()}', 'g'),
                  _summaryItem('Carbs', '${totals['carbs']!.toInt()}', 'g'),
                  _summaryItem('Fat', '${totals['fat']!.toInt()}', 'g'),
                ],
              ),
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                children: ['breakfast', 'lunch', 'dinner', 'snack'].map((type) {
                  final meals = mealProvider.getMealsByType(DateTime.now(), type);
                  if (meals.isEmpty) {
                    return EmptyStateWidget(
                      icon: Icons.restaurant,
                      title: 'No ${type} logged',
                      subtitle: 'Tap + to add your meal',
                      buttonText: 'Add ${type[0].toUpperCase()}${type.substring(1)}',
                      onButtonPressed: () => Navigator.pushNamed(context, AppRoutes.searchFood, arguments: type),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: meals.length,
                    itemBuilder: (ctx, i) => MealCard(
                      meal: meals[i],
                      onTap: () => Navigator.pushNamed(context, AppRoutes.mealDetail, arguments: meals[i]),
                      onDelete: () => mealProvider.deleteMeal(meals[i].id),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.addMeal),
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('$label ($unit)', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }
}
