import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/food_item_tile.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final mealType = ModalRoute.of(context)?.settings.arguments as String? ?? 'snack';
    final mealProvider = context.watch<MealProvider>();
    final categories = mealProvider.categories;

    var foods = mealProvider.searchFoods(_query);
    if (_selectedCategory != 'All') {
      foods = foods.where((f) => f.category == _selectedCategory).toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Search Food')),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search foods...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(icon: Icon(Icons.clear), onPressed: () { _searchController.clear(); setState(() => _query = ''); })
                    : null,
              ),
            ),
          ),

          // Category Chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final cat = categories[i];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat, style: TextStyle(fontSize: 12)),
                    selected: isSelected,
                    selectedColor: AppColors.primaryLight,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),

          // Food List
          Expanded(
            child: foods.isEmpty
                ? Center(child: Text('No foods found', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, i) {
                      final food = foods[i];
                      return FoodItemTile(
                        food: food,
                        onTap: () => _showAddDialog(context, food, mealType, mealProvider),
                        onFavoriteToggle: () => mealProvider.toggleFavorite(food.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context, dynamic food, String mealType, MealProvider provider) {
    double qty = 1;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(food.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${food.caloriesPerServing.toInt()} kcal per ${food.servingUnit}'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () { if (qty > 0.5) setDialogState(() => qty -= 0.5); },
                  ),
                  Text('$qty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () => setDialogState(() => qty += 0.5),
                  ),
                ],
              ),
              Text('Total: ${(food.caloriesPerServing * qty).toInt()} kcal',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                provider.addMealFromFood(food, mealType, qty);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${food.name} added to $mealType'), backgroundColor: AppColors.primary),
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
