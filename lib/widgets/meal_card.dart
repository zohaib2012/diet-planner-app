import 'package:flutter/material.dart';
import '../models/meal_log.dart';
import '../utils/constants.dart';

class MealCard extends StatelessWidget {
  final MealLog meal;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const MealCard({super.key, required this.meal, this.onTap, this.onDelete});

  IconData _getMealIcon() {
    switch (meal.mealType) {
      case 'breakfast': return Icons.free_breakfast;
      case 'lunch': return Icons.lunch_dining;
      case 'dinner': return Icons.dinner_dining;
      case 'snack': return Icons.cookie;
      default: return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(_getMealIcon(), color: AppColors.primaryDark, size: 20),
        ),
        title: Text(
          meal.foodName,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        subtitle: Text(
          'Qty: ${meal.quantity.toStringAsFixed(1)} | P: ${meal.totalProtein.toInt()}g  C: ${meal.totalCarbs.toInt()}g  F: ${meal.totalFat.toInt()}g',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${meal.totalCalories.toInt()} kcal',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 13),
            ),
            if (onDelete != null)
              IconButton(
                icon: Icon(Icons.delete_outline, size: 18, color: Colors.red[300]),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
