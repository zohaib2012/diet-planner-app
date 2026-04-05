import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class AboutHelpScreen extends StatelessWidget {
  const AboutHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About & Help')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // App Info
            Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                      child: Icon(Icons.restaurant_menu, size: 40, color: AppColors.primary),
                    ),
                    SizedBox(height: 12),
                    Text(AppStrings.appName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('Version 1.0.0', style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 8),
                    Text(
                      'Your personal nutrition companion for a healthier lifestyle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // FAQ
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    _faqTile('How are my daily calories calculated?',
                        'We use the Mifflin-St Jeor equation to calculate your BMR, then multiply by your activity level to get TDEE. Your goal (lose/maintain/gain) adjusts this by +/- 500 calories.'),
                    _faqTile('Can I use this app offline?',
                        'Yes! All data is stored locally on your device. No internet connection is needed.'),
                    _faqTile('How do I change my calorie goal?',
                        'Go to Settings > Edit Profile and update your weight, goal, or activity level. Your calories will be recalculated automatically.'),
                    _faqTile('What is BMI?',
                        'Body Mass Index is calculated as weight(kg) / height(m)^2. It gives a rough indicator of body fat. Normal range is 18.5 to 24.9.'),
                    _faqTile('How many glasses of water should I drink?',
                        'The default goal is 8 glasses (2000ml) per day. You can customize this in the Water Tracker settings.'),
                    _faqTile('Can I create my own recipes?',
                        'Yes! Go to Recipes tab and tap the + button to add your own custom recipes with ingredients and nutritional info.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Developer Info
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Developed By', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text('University Project', style: TextStyle(color: Colors.grey[600])),
                    Text('Mobile Application Development', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    SizedBox(height: 8),
                    Text('Built with Flutter', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(answer, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ),
      ],
    );
  }
}
