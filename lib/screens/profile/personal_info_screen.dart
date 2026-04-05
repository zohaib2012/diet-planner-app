import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController(text: '25');
  final _heightController = TextEditingController(text: '170');
  final _weightController = TextEditingController(text: '70');
  String _gender = 'male';

  void _next() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthProvider>().updateProfile(
      age: int.parse(_ageController.text),
      gender: _gender,
      heightCm: double.parse(_heightController.text),
      weightKg: double.parse(_weightController.text),
    );

    Navigator.pushNamed(context, AppRoutes.goalSelection);
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Info'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Step 1 of 4', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                LinearProgressIndicator(value: 0.25, backgroundColor: Colors.grey[200], color: AppColors.primary),
                SizedBox(height: 24),
                Text('Tell us about yourself', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 24),

                // Gender Selection
                Text('Gender', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                SizedBox(height: 8),
                Row(
                  children: [
                    _genderCard('male', Icons.male, 'Male'),
                    SizedBox(width: 12),
                    _genderCard('female', Icons.female, 'Female'),
                    SizedBox(width: 12),
                    _genderCard('other', Icons.person, 'Other'),
                  ],
                ),
                SizedBox(height: 20),

                // Age
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age', prefixIcon: Icon(Icons.cake), suffixText: 'years'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    final age = int.tryParse(v);
                    if (age == null || age < 10 || age > 100) return 'Enter valid age (10-100)';
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Height
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height', prefixIcon: Icon(Icons.height), suffixText: 'cm'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    final h = double.tryParse(v);
                    if (h == null || h < 100 || h > 250) return 'Enter valid height (100-250 cm)';
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Weight
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight', prefixIcon: Icon(Icons.monitor_weight), suffixText: 'kg'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    final w = double.tryParse(v);
                    if (w == null || w < 30 || w > 300) return 'Enter valid weight (30-300 kg)';
                    return null;
                  },
                ),
                SizedBox(height: 32),

                CustomButton(text: 'Next', onPressed: _next, icon: Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderCard(String value, IconData icon, String label) {
    final isSelected = _gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = value),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[300]!, width: isSelected ? 2 : 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : Colors.grey, size: 28),
              SizedBox(height: 4),
              Text(label, style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
