import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/meal_log.dart';
import '../../providers/meal_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController(text: '0');
  final _carbsController = TextEditingController(text: '0');
  final _fatController = TextEditingController(text: '0');
  final _quantityController = TextEditingController(text: '1');
  String _mealType = 'breakfast';

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final meal = MealLog(
      id: const Uuid().v4(),
      foodName: _nameController.text.trim(),
      calories: double.parse(_caloriesController.text),
      protein: double.parse(_proteinController.text),
      carbs: double.parse(_carbsController.text),
      fat: double.parse(_fatController.text),
      quantity: double.parse(_quantityController.text),
      mealType: _mealType,
      date: DateTime.now(),
    );

    context.read<MealProvider>().addMeal(meal);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meal added successfully'), backgroundColor: AppColors.primary),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Meal')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Food Name', prefixIcon: Icon(Icons.fastfood)),
                validator: (v) => Helpers.validateRequired(v, 'Food name'),
              ),
              SizedBox(height: 12),

              // Meal Type Dropdown
              DropdownButtonFormField<String>(
                value: _mealType,
                decoration: InputDecoration(labelText: 'Meal Type', prefixIcon: Icon(Icons.restaurant)),
                items: ['breakfast', 'lunch', 'dinner', 'snack']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t[0].toUpperCase() + t.substring(1))))
                    .toList(),
                onChanged: (v) => setState(() => _mealType = v!),
              ),
              SizedBox(height: 12),

              TextFormField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Calories (per serving)', prefixIcon: Icon(Icons.local_fire_department), suffixText: 'kcal'),
                validator: (v) => Helpers.validateNumber(v, 'Calories'),
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Protein', suffixText: 'g'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Carbs', suffixText: 'g'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _fatController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Fat', suffixText: 'g'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity (servings)', prefixIcon: Icon(Icons.numbers)),
                validator: (v) => Helpers.validateNumber(v, 'Quantity'),
              ),
              SizedBox(height: 24),

              CustomButton(text: 'Save Meal', onPressed: _save, icon: Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
