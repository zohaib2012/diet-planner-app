import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/constants.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              // Recipe Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.restaurant_menu, color: AppColors.primaryDark, size: 28),
              ),
              SizedBox(width: 12),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        _chip(recipe.cuisine),
                        SizedBox(width: 6),
                        _chip(recipe.dietType),
                        SizedBox(width: 6),
                        _chip('${recipe.totalTimeMinutes} min'),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${recipe.caloriesPerServing.toInt()} kcal | P: ${recipe.proteinPerServing.toInt()}g  C: ${recipe.carbsPerServing.toInt()}g  F: ${recipe.fatPerServing.toInt()}g',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: Colors.grey[700])),
    );
  }
}
