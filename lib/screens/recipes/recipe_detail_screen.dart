import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: recipe.isCustom
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.editRecipe,
                    arguments: recipe,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDelete(context, recipe),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info row
            _buildInfoRow(recipe),
            const SizedBox(height: 20),

            // Nutrition card
            _buildNutritionCard(recipe),
            const SizedBox(height: 20),

            // Ingredients
            _sectionTitle('Ingredients'),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
            const SizedBox(height: 20),

            // Cooking steps button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('View Cooking Steps'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.cookingSteps,
                  arguments: recipe,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(Recipe recipe) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _infoChip(Icons.restaurant, recipe.cuisine),
        _infoChip(Icons.eco, recipe.dietType),
        _infoChip(Icons.access_time, '${recipe.prepTimeMinutes}m prep'),
        _infoChip(Icons.local_fire_department, '${recipe.cookTimeMinutes}m cook'),
        _infoChip(Icons.people, '${recipe.servings} servings'),
        _infoChip(Icons.schedule, '${recipe.totalTimeMinutes}m total'),
      ],
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildNutritionCard(Recipe recipe) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Nutrition per Serving'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _nutrientItem('Calories', '${recipe.caloriesPerServing.toInt()}', 'kcal', AppColors.primary),
                _nutrientItem('Protein', '${recipe.proteinPerServing.toInt()}', 'g', AppColors.proteinColor),
                _nutrientItem('Carbs', '${recipe.carbsPerServing.toInt()}', 'g', AppColors.carbsColor),
                _nutrientItem('Fat', '${recipe.fatPerServing.toInt()}', 'g', AppColors.fatColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutrientItem(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        Text(unit, style: TextStyle(fontSize: 12, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  void _confirmDelete(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text('Are you sure you want to delete "${recipe.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Provider.of<RecipeProvider>(ctx, listen: false).deleteRecipe(recipe.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
