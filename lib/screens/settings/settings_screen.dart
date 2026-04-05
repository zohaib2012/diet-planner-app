import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          // Profile Header
          if (user != null)
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(user.name[0].toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(user.email, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          Divider(),
          _tile(context, Icons.person, 'Edit Profile', AppRoutes.editProfile),
          _tile(context, Icons.palette, 'Theme', AppRoutes.themeSettings),
          _tile(context, Icons.straighten, 'Units', AppRoutes.unitSettings),
          _tile(context, Icons.water_drop, 'Water Tracker', AppRoutes.waterTracker),
          _tile(context, Icons.notifications, 'Reminders', AppRoutes.reminderList),
          _tile(context, Icons.food_bank, 'Diet Plans', AppRoutes.choosePlan),
          _tile(context, Icons.favorite, 'Favorite Foods', AppRoutes.favoriteFoods),
          _tile(context, Icons.info, 'About & Help', AppRoutes.aboutHelp),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.error),
            title: Text('Logout', style: TextStyle(color: AppColors.error)),
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, size: 18),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
