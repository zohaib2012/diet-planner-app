import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class TdeeResultScreen extends StatelessWidget {
  const TdeeResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text('Your Plan'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.check_circle, size: 64, color: AppColors.primary),
              SizedBox(height: 12),
              Text('Your Profile is Ready!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Here is your personalized daily plan', style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 24),

              // Daily Calories Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text('Daily Calorie Goal', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Text(
                        '${user.dailyCalories.toInt()}',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      Text('kcal / day', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Macros Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daily Macros Target', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(height: 16),
                      _macroRow('Protein', user.proteinGoal, AppColors.proteinColor, '30%'),
                      SizedBox(height: 12),
                      _macroRow('Carbs', user.carbsGoal, AppColors.carbsColor, '45%'),
                      SizedBox(height: 12),
                      _macroRow('Fat', user.fatGoal, AppColors.fatColor, '25%'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Info Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _infoRow(Icons.person, 'Gender', user.gender.toUpperCase()),
                      Divider(),
                      _infoRow(Icons.cake, 'Age', '${user.age} years'),
                      Divider(),
                      _infoRow(Icons.height, 'Height', '${user.heightCm.toInt()} cm'),
                      Divider(),
                      _infoRow(Icons.monitor_weight, 'Weight', '${user.weightKg.toStringAsFixed(1)} kg'),
                      Divider(),
                      _infoRow(Icons.flag, 'Goal', user.goal == 'lose' ? 'Lose Weight' : user.goal == 'gain' ? 'Gain Weight' : 'Maintain Weight'),
                      Divider(),
                      _infoRow(Icons.directions_run, 'Activity', user.activityLevel.replaceAll('_', ' ')),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),

              CustomButton(
                text: 'Start My Journey',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (route) => false);
                },
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _macroRow(String label, double grams, Color color, String percentage) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        SizedBox(width: 10),
        Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.w500))),
        Text('${grams.toInt()}g', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Text('($percentage)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          SizedBox(width: 12),
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Spacer(),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
