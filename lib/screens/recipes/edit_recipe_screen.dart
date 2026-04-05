import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/constants.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({super.key});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _cuisineCtrl;
  late TextEditingController _prepTimeCtrl;
  late TextEditingController _cookTimeCtrl;
  late TextEditingController _servingsCtrl;
  late TextEditingController _caloriesCtrl;
  late TextEditingController _proteinCtrl;
  late TextEditingController _carbsCtrl;
  late TextEditingController _fatCtrl;

  late String _dietType;
  late String _mealType;
  late List<TextEditingController> _ingredientCtrls;
  late List<TextEditingController> _stepCtrls;
  late Recipe _recipe;
  bool _initialized = false;

  final List<String> _dietTypes = ['veg', 'non-veg', 'vegan'];
  final List<String> _mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
      _nameCtrl = TextEditingController(text: _recipe.name);
      _cuisineCtrl = TextEditingController(text: _recipe.cuisine);
      _prepTimeCtrl = TextEditingController(text: '${_recipe.prepTimeMinutes}');
      _cookTimeCtrl = TextEditingController(text: '${_recipe.cookTimeMinutes}');
      _servingsCtrl = TextEditingController(text: '${_recipe.servings}');
      _caloriesCtrl = TextEditingController(text: '${_recipe.caloriesPerServing}');
      _proteinCtrl = TextEditingController(text: '${_recipe.proteinPerServing}');
      _carbsCtrl = TextEditingController(text: '${_recipe.carbsPerServing}');
      _fatCtrl = TextEditingController(text: '${_recipe.fatPerServing}');
      _dietType = _recipe.dietType;
      _mealType = _recipe.mealType;
      _ingredientCtrls = _recipe.ingredients.map((e) => TextEditingController(text: e)).toList();
      _stepCtrls = _recipe.steps.map((e) => TextEditingController(text: e)).toList();
      _initialized = true;
    }
  }

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

    final ingredients = _ingredientCtrls.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList();
    final steps = _stepCtrls.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList();

    if (ingredients.isEmpty || steps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one ingredient and one step')),
      );
      return;
    }

    final updated = Recipe(
      id: _recipe.id,
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

    Provider.of<RecipeProvider>(context, listen: false).updateRecipe(_recipe.id, updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Recipe')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _textField(_nameCtrl, 'Recipe Name', required: true),
            const SizedBox(height: 12),
            _textField(_cuisineCtrl, 'Cuisine', required: true),
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
              child: const Text('Update Recipe', style: TextStyle(fontSize: 16)),
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
