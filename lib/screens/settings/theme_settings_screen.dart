import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/constants.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Theme')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            _themeCard(
              context,
              'Light Mode',
              'Clean and bright appearance',
              Icons.light_mode,
              ThemeMode.light,
              themeProvider,
            ),
            SizedBox(height: 8),
            _themeCard(
              context,
              'Dark Mode',
              'Easy on the eyes, saves battery',
              Icons.dark_mode,
              ThemeMode.dark,
              themeProvider,
            ),
            SizedBox(height: 8),
            _themeCard(
              context,
              'System Default',
              'Follow your device settings',
              Icons.settings_brightness,
              ThemeMode.system,
              themeProvider,
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeCard(BuildContext context, String title, String subtitle, IconData icon, ThemeMode mode, ThemeProvider provider) {
    final isSelected = provider.themeMode == mode;
    return Card(
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppColors.primary : Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
        trailing: isSelected ? Icon(Icons.check_circle, color: AppColors.primary) : null,
        onTap: () => provider.setThemeMode(mode),
        tileColor: isSelected ? AppColors.primaryLight.withOpacity(0.2) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
