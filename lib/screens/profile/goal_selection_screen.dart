import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String _selectedGoal = 'maintain';

  final List<Map<String, dynamic>> _goals = [
    {
      'value': 'lose',
      'title': 'Lose Weight',
      'subtitle': 'Reduce body fat and get leaner',
      'icon': Icons.trending_down,
      'color': Colors.orange,
    },
    {
      'value': 'maintain',
      'title': 'Maintain Weight',
      'subtitle': 'Keep your current weight steady',
      'icon': Icons.balance,
      'color': AppColors.primary,
    },
    {
      'value': 'gain',
      'title': 'Gain Weight',
      'subtitle': 'Build muscle and increase mass',
      'icon': Icons.trending_up,
      'color': AppColors.waterColor,
    },
  ];

  void _next() {
    context.read<AuthProvider>().updateProfile(goal: _selectedGoal);
    Navigator.pushNamed(context, AppRoutes.activityLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Goal')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Step 2 of 4', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              LinearProgressIndicator(value: 0.5, backgroundColor: Colors.grey[200], color: AppColors.primary),
              SizedBox(height: 24),
              Text('What is your goal?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),

              ...List.generate(_goals.length, (i) {
                final goal = _goals[i];
                final isSelected = _selectedGoal == goal['value'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedGoal = goal['value']),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? (goal['color'] as Color).withOpacity(0.1) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? goal['color'] : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (goal['color'] as Color).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(goal['icon'], color: goal['color'], size: 28),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(goal['title'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                              Text(goal['subtitle'], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: goal['color']),
                      ],
                    ),
                  ),
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
