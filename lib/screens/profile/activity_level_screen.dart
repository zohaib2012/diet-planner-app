import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  String _selected = 'moderate';

  final List<Map<String, String>> _levels = [
    {'value': 'sedentary', 'title': 'Sedentary', 'desc': 'Little or no exercise, desk job'},
    {'value': 'light', 'title': 'Lightly Active', 'desc': 'Light exercise 1-3 days/week'},
    {'value': 'moderate', 'title': 'Moderately Active', 'desc': 'Moderate exercise 3-5 days/week'},
    {'value': 'active', 'title': 'Active', 'desc': 'Hard exercise 6-7 days/week'},
    {'value': 'very_active', 'title': 'Very Active', 'desc': 'Very hard exercise, physical job'},
  ];

  void _next() {
    context.read<AuthProvider>().updateProfile(activityLevel: _selected);
    Navigator.pushNamed(context, AppRoutes.dietaryPreference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Level')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Step 3 of 4', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              LinearProgressIndicator(value: 0.75, backgroundColor: Colors.grey[200], color: AppColors.primary),
              SizedBox(height: 24),
              Text('How active are you?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              ...List.generate(_levels.length, (i) {
                final level = _levels[i];
                final isSelected = _selected == level['value'];
                return RadioListTile<String>(
                  value: level['value']!,
                  groupValue: _selected,
                  onChanged: (v) => setState(() => _selected = v!),
                  title: Text(level['title']!, style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(level['desc']!, style: TextStyle(fontSize: 12)),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: isSelected ? AppColors.primary : Colors.transparent),
                  ),
                  tileColor: isSelected ? AppColors.primaryLight.withOpacity(0.3) : null,
                );
              }),

              Spacer(),
              CustomButton(text: 'Next', onPressed: _next, icon: Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
