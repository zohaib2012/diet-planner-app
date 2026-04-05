import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/diet_plan_provider.dart';
import '../../utils/constants.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final Set<int> _checkedItems = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DietPlanProvider>(context);
    final groceryItems = provider.generateGroceryList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          if (_checkedItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Uncheck all',
              onPressed: () => setState(() => _checkedItems.clear()),
            ),
        ],
      ),
      body: groceryItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textSecondary),
                  SizedBox(height: 12),
                  Text(
                    'No active plan selected',
                    style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Progress bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: groceryItems.isEmpty
                                ? 0
                                : _checkedItems.length / groceryItems.length,
                            backgroundColor: AppColors.primaryLight,
                            color: AppColors.primary,
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_checkedItems.length}/${groceryItems.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Grocery items list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: groceryItems.length,
                    itemBuilder: (context, index) {
                      final isChecked = _checkedItems.contains(index);
                      return CheckboxListTile(
                        value: isChecked,
                        activeColor: AppColors.primary,
                        title: Text(
                          groceryItems[index],
                          style: TextStyle(
                            decoration: isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: isChecked
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _checkedItems.add(index);
                            } else {
                              _checkedItems.remove(index);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
