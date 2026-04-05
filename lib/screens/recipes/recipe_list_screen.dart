import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';
import '../../widgets/recipe_card.dart';
import '../../widgets/empty_state_widget.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final _searchController = TextEditingController();
  String _selectedMealType = 'All';
  String _selectedCuisine = 'All';

  final List<String> _mealTypes = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final cuisines = provider.cuisines;
    final recipes = provider.filterRecipes(
      query: _searchController.text,
      mealType: _selectedMealType,
      cuisine: _selectedCuisine,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // Meal type chips
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _mealTypes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final type = _mealTypes[index];
                final selected = _selectedMealType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: selected,
                  selectedColor: AppColors.primaryLight,
                  onSelected: (_) => setState(() => _selectedMealType = type),
                );
              },
            ),
          ),
          const SizedBox(height: 4),

          // Cuisine chips
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cuisines.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cuisine = cuisines[index];
                final selected = _selectedCuisine == cuisine;
                return ChoiceChip(
                  label: Text(cuisine),
                  selected: selected,
                  selectedColor: AppColors.primaryLight,
                  onSelected: (_) => setState(() => _selectedCuisine = cuisine),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Recipe list
          Expanded(
            child: recipes.isEmpty
                ? const EmptyStateWidget(
                    icon: Icons.restaurant_menu,
                    message: 'No recipes found',
                  )
                : ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.recipeDetail,
                          arguments: recipe,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addRecipe),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
