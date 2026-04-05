import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/reminder_provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';

class ReminderListScreen extends StatelessWidget {
  const ReminderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReminderProvider>();
    final reminders = provider.reminders;

    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: reminders.isEmpty
          ? Center(child: Text('No reminders set', style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: reminders.length,
              itemBuilder: (context, i) {
                final r = reminders[i];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: r.type == 'meal'
                          ? AppColors.primaryLight
                          : r.type == 'water'
                              ? AppColors.waterColor.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                      child: Icon(
                        r.type == 'meal'
                            ? Icons.restaurant
                            : r.type == 'water'
                                ? Icons.water_drop
                                : Icons.monitor_weight,
                        color: r.type == 'meal'
                            ? AppColors.primary
                            : r.type == 'water'
                                ? AppColors.waterColor
                                : Colors.orange,
                        size: 20,
                      ),
                    ),
                    title: Text(r.title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    subtitle: Text('${r.timeString} | ${r.daysString}', style: TextStyle(fontSize: 12)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: r.isActive,
                          onChanged: (_) => provider.toggleReminder(r.id),
                          activeColor: AppColors.primary,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, size: 18, color: Colors.red[300]),
                          onPressed: () => provider.deleteReminder(r.id),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.addReminder, arguments: r),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addReminder),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
