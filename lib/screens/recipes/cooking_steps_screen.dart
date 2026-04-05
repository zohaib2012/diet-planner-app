import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../utils/constants.dart';

class CookingStepsScreen extends StatefulWidget {
  const CookingStepsScreen({super.key});

  @override
  State<CookingStepsScreen> createState() => _CookingStepsScreenState();
}

class _CookingStepsScreenState extends State<CookingStepsScreen> {
  final List<bool> _completed = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
      _completed.addAll(List.filled(recipe.steps.length, false));
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    final completedCount = _completed.where((v) => v).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${recipe.name} - Steps'),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$completedCount of ${recipe.steps.length} steps completed',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    if (completedCount == recipe.steps.length)
                      const Icon(Icons.check_circle, color: AppColors.primary, size: 24),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: recipe.steps.isEmpty ? 0 : completedCount / recipe.steps.length,
                  backgroundColor: AppColors.primaryLight,
                  color: AppColors.primary,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),

          // Steps list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recipe.steps.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: _completed[index],
                  activeColor: AppColors.primary,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (val) => setState(() => _completed[index] = val ?? false),
                  title: Text(
                    'Step ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: _completed[index] ? Colors.grey : null,
                    ),
                  ),
                  subtitle: Text(
                    recipe.steps[index],
                    style: TextStyle(
                      fontSize: 14,
                      decoration: _completed[index] ? TextDecoration.lineThrough : null,
                      color: _completed[index] ? Colors.grey : null,
                    ),
                  ),
                );
              },
            ),
          ),

          // Done message
          if (completedCount == recipe.steps.length && recipe.steps.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: AppColors.primaryLight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.celebration, color: AppColors.primaryDark),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'All steps completed! Enjoy your meal!',
                          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
