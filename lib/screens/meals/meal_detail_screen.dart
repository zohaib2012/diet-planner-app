import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/meal_log.dart';
import '../../providers/meal_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../utils/app_routes.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as MealLog;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editMeal, arguments: meal),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red[200]),
            onPressed: () {
              context.read<MealProvider>().deleteMeal(meal.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Meal deleted')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      radius: 28,
                      child: Icon(Icons.restaurant, color: AppColors.primary, size: 28),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meal.foodName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('${meal.mealType[0].toUpperCase()}${meal.mealType.substring(1)} | ${Helpers.formatDate(meal.date)}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),

            // Nutrition Info
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nutritional Information', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    SizedBox(height: 16),
                    _nutritionRow('Calories', '${meal.totalCalories.toInt()} kcal', AppColors.primary),
                    Divider(),
                    _nutritionRow('Protein', '${meal.totalProtein.toStringAsFixed(1)}g', AppColors.proteinColor),
                    Divider(),
                    _nutritionRow('Carbs', '${meal.totalCarbs.toStringAsFixed(1)}g', AppColors.carbsColor),
                    Divider(),
                    _nutritionRow('Fat', '${meal.totalFat.toStringAsFixed(1)}g', AppColors.fatColor),
                    Divider(),
                    _nutritionRow('Quantity', '${meal.quantity} servings', Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutritionRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14))),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }
}
