import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/meal_log.dart';
import '../../providers/meal_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/custom_button.dart';

class EditMealScreen extends StatefulWidget {
  const EditMealScreen({super.key});

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _carbsController;
  late TextEditingController _fatController;
  late TextEditingController _quantityController;
  late String _mealType;
  late MealLog _meal;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _meal = ModalRoute.of(context)!.settings.arguments as MealLog;
      _nameController = TextEditingController(text: _meal.foodName);
      _caloriesController = TextEditingController(text: _meal.calories.toString());
      _proteinController = TextEditingController(text: _meal.protein.toString());
      _carbsController = TextEditingController(text: _meal.carbs.toString());
      _fatController = TextEditingController(text: _meal.fat.toString());
      _quantityController = TextEditingController(text: _meal.quantity.toString());
      _mealType = _meal.mealType;
      _initialized = true;
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = MealLog(
      id: _meal.id,
      foodName: _nameController.text.trim(),
      calories: double.parse(_caloriesController.text),
      protein: double.parse(_proteinController.text),
      carbs: double.parse(_carbsController.text),
      fat: double.parse(_fatController.text),
      quantity: double.parse(_quantityController.text),
      mealType: _mealType,
      date: _meal.date,
    );

    context.read<MealProvider>().updateMeal(_meal.id, updated);
    Navigator.pop(context);
    Navigator.pop(context); // Go back past detail screen too
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meal updated'), backgroundColor: AppColors.primary),
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
      appBar: AppBar(title: Text('Edit Meal')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Food Name', prefixIcon: Icon(Icons.fastfood)),
                validator: (v) => Helpers.validateRequired(v, 'Food name'),
              ),
              SizedBox(height: 12),
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
                decoration: InputDecoration(labelText: 'Calories', suffixText: 'kcal'),
                validator: (v) => Helpers.validateNumber(v, 'Calories'),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: TextFormField(controller: _proteinController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Protein', suffixText: 'g'))),
                  SizedBox(width: 8),
                  Expanded(child: TextFormField(controller: _carbsController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Carbs', suffixText: 'g'))),
                  SizedBox(width: 8),
                  Expanded(child: TextFormField(controller: _fatController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Fat', suffixText: 'g'))),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity', prefixIcon: Icon(Icons.numbers)),
              ),
              SizedBox(height: 24),
              CustomButton(text: 'Update Meal', onPressed: _save, icon: Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
