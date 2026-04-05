import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';
import '../../widgets/food_item_tile.dart';
import '../../widgets/empty_state_widget.dart';

class FavoriteFoodsScreen extends StatelessWidget {
  const FavoriteFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = context.watch<MealProvider>();
    final favorites = mealProvider.favoriteFoods;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Foods')),
      body: favorites.isEmpty
          ? EmptyStateWidget(
              icon: Icons.favorite_border,
              title: 'No favorites yet',
              subtitle: 'Mark foods as favorite from the search screen',
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, i) => FoodItemTile(
                food: favorites[i],
                onFavoriteToggle: () => mealProvider.toggleFavorite(favorites[i].id),
              ),
            ),
    );
  }
}
