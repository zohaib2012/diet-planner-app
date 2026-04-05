import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late String _gender;
  late String _goal;
  late String _activityLevel;
  late String _dietaryPref;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser!;
    _nameController = TextEditingController(text: user.name);
    _ageController = TextEditingController(text: user.age.toString());
    _heightController = TextEditingController(text: user.heightCm.toString());
    _weightController = TextEditingController(text: user.weightKg.toString());
    _gender = user.gender;
    _goal = user.goal;
    _activityLevel = user.activityLevel;
    _dietaryPref = user.dietaryPref;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthProvider>().updateProfile(
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text),
      gender: _gender,
      heightCm: double.parse(_heightController.text),
      weightKg: double.parse(_weightController.text),
      goal: _goal,
      activityLevel: _activityLevel,
      dietaryPref: _dietaryPref,
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated! Calories recalculated.'), backgroundColor: AppColors.primary),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nameController, decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person))),
              SizedBox(height: 12),
              TextFormField(controller: _ageController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Age', prefixIcon: Icon(Icons.cake))),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'Gender', prefixIcon: Icon(Icons.people)),
                items: ['male', 'female', 'other'].map((g) => DropdownMenuItem(value: g, child: Text(g[0].toUpperCase() + g.substring(1)))).toList(),
                onChanged: (v) => setState(() => _gender = v!),
              ),
              SizedBox(height: 12),
              TextFormField(controller: _heightController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Height (cm)', prefixIcon: Icon(Icons.height))),
              SizedBox(height: 12),
              TextFormField(controller: _weightController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Weight (kg)', prefixIcon: Icon(Icons.monitor_weight))),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _goal,
                decoration: InputDecoration(labelText: 'Goal', prefixIcon: Icon(Icons.flag)),
                items: [
                  DropdownMenuItem(value: 'lose', child: Text('Lose Weight')),
                  DropdownMenuItem(value: 'maintain', child: Text('Maintain Weight')),
                  DropdownMenuItem(value: 'gain', child: Text('Gain Weight')),
                ],
                onChanged: (v) => setState(() => _goal = v!),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _activityLevel,
                decoration: InputDecoration(labelText: 'Activity Level', prefixIcon: Icon(Icons.directions_run)),
                items: [
                  DropdownMenuItem(value: 'sedentary', child: Text('Sedentary')),
                  DropdownMenuItem(value: 'light', child: Text('Lightly Active')),
                  DropdownMenuItem(value: 'moderate', child: Text('Moderately Active')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'very_active', child: Text('Very Active')),
                ],
                onChanged: (v) => setState(() => _activityLevel = v!),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _dietaryPref,
                decoration: InputDecoration(labelText: 'Dietary Preference', prefixIcon: Icon(Icons.eco)),
                items: [
                  DropdownMenuItem(value: 'non-veg', child: Text('Non-Vegetarian')),
                  DropdownMenuItem(value: 'veg', child: Text('Vegetarian')),
                  DropdownMenuItem(value: 'vegan', child: Text('Vegan')),
                  DropdownMenuItem(value: 'eggetarian', child: Text('Eggetarian')),
                ],
                onChanged: (v) => setState(() => _dietaryPref = v!),
              ),
              SizedBox(height: 24),
              CustomButton(text: 'Save Changes', onPressed: _save, icon: Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
