import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class DietaryPreferenceScreen extends StatefulWidget {
  const DietaryPreferenceScreen({super.key});

  @override
  State<DietaryPreferenceScreen> createState() => _DietaryPreferenceScreenState();
}

class _DietaryPreferenceScreenState extends State<DietaryPreferenceScreen> {
  String _selected = 'non-veg';

  final List<Map<String, dynamic>> _prefs = [
    {'value': 'non-veg', 'title': 'Non-Vegetarian', 'icon': Icons.set_meal, 'desc': 'All food groups including meat and fish'},
    {'value': 'veg', 'title': 'Vegetarian', 'icon': Icons.eco, 'desc': 'No meat or fish, includes dairy and eggs'},
    {'value': 'vegan', 'title': 'Vegan', 'icon': Icons.grass, 'desc': 'Only plant-based foods, no animal products'},
    {'value': 'eggetarian', 'title': 'Eggetarian', 'icon': Icons.egg, 'desc': 'Vegetarian + eggs, no meat or fish'},
  ];

  void _finish() {
    context.read<AuthProvider>().updateProfile(dietaryPref: _selected);
    Navigator.pushNamed(context, AppRoutes.tdeeResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dietary Preference')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Step 4 of 4', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              LinearProgressIndicator(value: 1.0, backgroundColor: Colors.grey[200], color: AppColors.primary),
              SizedBox(height: 24),
              Text('Your diet preference?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _prefs.map((pref) {
                  final isSelected = _selected == pref['value'];
                  return GestureDetector(
                    onTap: () => setState(() => _selected = pref['value']),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryLight : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[300]!, width: isSelected ? 2 : 1),
                      ),
                      child: Column(
                        children: [
                          Icon(pref['icon'], size: 36, color: isSelected ? AppColors.primary : Colors.grey),
                          SizedBox(height: 8),
                          Text(pref['title'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isSelected ? AppColors.primary : AppColors.textPrimary), textAlign: TextAlign.center),
                          SizedBox(height: 4),
                          Text(pref['desc'], style: TextStyle(fontSize: 10, color: Colors.grey[600]), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              Spacer(),
              CustomButton(text: 'Calculate My Plan', onPressed: _finish, icon: Icons.calculate),
            ],
          ),
        ),
      ),
    );
  }
}
