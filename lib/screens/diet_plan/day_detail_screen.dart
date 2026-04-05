import 'package:flutter/material.dart';
import '../../models/diet_plan.dart';
import '../../utils/constants.dart';

class DayDetailScreen extends StatelessWidget {
  const DayDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dayPlan = ModalRoute.of(context)!.settings.arguments as DayPlan;

    final totalProtein = dayPlan.meals.fold<double>(0, (sum, m) => sum + m.protein);
    final totalCarbs = dayPlan.meals.fold<double>(0, (sum, m) => sum + m.carbs);
    final totalFat = dayPlan.meals.fold<double>(0, (sum, m) => sum + m.fat);

    return Scaffold(
      appBar: AppBar(title: Text(dayPlan.dayName)),
      body: Column(
        children: [
          // Nutrition summary card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '${dayPlan.totalCalories.toInt()} kcal',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Total Calories',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NutrientChip(
                      label: 'Protein',
                      value: '${totalProtein.toInt()}g',
                      color: AppColors.proteinColor,
                    ),
                    _NutrientChip(
                      label: 'Carbs',
                      value: '${totalCarbs.toInt()}g',
                      color: AppColors.carbsColor,
                    ),
                    _NutrientChip(
                      label: 'Fat',
                      value: '${totalFat.toInt()}g',
                      color: AppColors.fatColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Meal list header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Meals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Meal list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dayPlan.meals.length,
              itemBuilder: (context, index) {
                final meal = dayPlan.meals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meal type and name
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                meal.mealType,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${meal.calories.toInt()} kcal',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          meal.recipeName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Macro row
                        Row(
                          children: [
                            _MacroLabel('P: ${meal.protein.toInt()}g', AppColors.proteinColor),
                            const SizedBox(width: 16),
                            _MacroLabel('C: ${meal.carbs.toInt()}g', AppColors.carbsColor),
                            const SizedBox(width: 16),
                            _MacroLabel('F: ${meal.fat.toInt()}g', AppColors.fatColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _NutrientChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MacroLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _MacroLabel(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color),
    );
  }
}
