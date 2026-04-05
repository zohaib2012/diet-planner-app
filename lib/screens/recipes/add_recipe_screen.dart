import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/recipe.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/constants.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _cuisineCtrl = TextEditingController();
  final _prepTimeCtrl = TextEditingController(text: '10');
  final _cookTimeCtrl = TextEditingController(text: '20');
  final _servingsCtrl = TextEditingController(text: '2');
  final _caloriesCtrl = TextEditingController();
  final _proteinCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();

  String _dietType = 'veg';
  String _mealType = 'breakfast';
  final List<TextEditingController> _ingredientCtrls = [TextEditingController()];
  final List<TextEditingController> _stepCtrls = [TextEditingController()];

  final List<String> _dietTypes = ['veg', 'non-veg', 'vegan'];
  final List<String> _mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cuisineCtrl.dispose();
    _prepTimeCtrl.dispose();
    _cookTimeCtrl.dispose();
    _servingsCtrl.dispose();
    _caloriesCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    for (final c in _ingredientCtrls) { c.dispose(); }
    for (final c in _stepCtrls) { c.dispose(); }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientCtrls
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final steps = _stepCtrls
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (ingredients.isEmpty || steps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one ingredient and one step')),
      );
      return;
    }

    final recipe = Recipe(
      id: const Uuid().v4(),
      name: _nameCtrl.text.trim(),
      cuisine: _cuisineCtrl.text.trim(),
      dietType: _dietType,
      mealType: _mealType,
      prepTimeMinutes: int.tryParse(_prepTimeCtrl.text) ?? 10,
      cookTimeMinutes: int.tryParse(_cookTimeCtrl.text) ?? 20,
      servings: int.tryParse(_servingsCtrl.text) ?? 2,
      ingredients: ingredients,
      steps: steps,
      caloriesPerServing: double.tryParse(_caloriesCtrl.text) ?? 0,
      proteinPerServing: double.tryParse(_proteinCtrl.text) ?? 0,
      carbsPerServing: double.tryParse(_carbsCtrl.text) ?? 0,
      fatPerServing: double.tryParse(_fatCtrl.text) ?? 0,
      isCustom: true,
    );

    Provider.of<RecipeProvider>(context, listen: false).addRecipe(recipe);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _textField(_nameCtrl, 'Recipe Name', required: true),
            const SizedBox(height: 12),
            _textField(_cuisineCtrl, 'Cuisine (e.g. Indian)', required: true),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _dropdown('Diet Type', _dietType, _dietTypes, (v) => setState(() => _dietType = v!))),
                const SizedBox(width: 12),
                Expanded(child: _dropdown('Meal Type', _mealType, _mealTypes, (v) => setState(() => _mealType = v!))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField(_prepTimeCtrl, 'Prep (min)')),
                const SizedBox(width: 12),
                Expanded(child: _numberField(_cookTimeCtrl, 'Cook (min)')),
                const SizedBox(width: 12),
                Expanded(child: _numberField(_servingsCtrl, 'Servings')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField(_caloriesCtrl, 'Calories')),
                const SizedBox(width: 12),
                Expanded(child: _numberField(_proteinCtrl, 'Protein (g)')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField(_carbsCtrl, 'Carbs (g)')),
                const SizedBox(width: 12),
                Expanded(child: _numberField(_fatCtrl, 'Fat (g)')),
              ],
            ),
            const SizedBox(height: 20),
            _dynamicListSection('Ingredients', _ingredientCtrls),
            const SizedBox(height: 20),
            _dynamicListSection('Steps', _stepCtrls),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Recipe', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(TextEditingController ctrl, String label, {bool required = false}) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null : null,
    );
  }

  Widget _numberField(TextEditingController ctrl, String label) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: TextInputType.number,
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _dynamicListSection(String title, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: () => setState(() => controllers.add(TextEditingController())),
            ),
          ],
        ),
        ...List.generate(controllers.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers[i],
                    decoration: InputDecoration(
                      hintText: '$title ${i + 1}',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                if (controllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => setState(() {
                      controllers[i].dispose();
                      controllers.removeAt(i);
                    }),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
