import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem food;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const FoodItemTile({super.key, required this.food, this.onTap, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Text(
            food.name[0].toUpperCase(),
            style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(food.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        subtitle: Text(
          '${food.caloriesPerServing.toInt()} kcal per ${food.servingUnit} | ${food.category}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(
            food.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: food.isFavorite ? Colors.red : Colors.grey,
            size: 20,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
