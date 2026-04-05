import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/reminder_model.dart';
import '../../providers/reminder_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _titleController = TextEditingController();
  String _type = 'meal';
  TimeOfDay _time = TimeOfDay(hour: 8, minute: 0);
  List<int> _repeatDays = [1, 2, 3, 4, 5, 6, 7];
  bool _isEditing = false;
  String? _editId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reminder = ModalRoute.of(context)?.settings.arguments as ReminderModel?;
    if (reminder != null && !_isEditing) {
      _isEditing = true;
      _editId = reminder.id;
      _titleController.text = reminder.title;
      _type = reminder.type;
      _time = TimeOfDay(hour: reminder.hour, minute: reminder.minute);
      _repeatDays = List.from(reminder.repeatDays);
    }
  }

  void _save() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a title')));
      return;
    }

    final provider = context.read<ReminderProvider>();
    final reminder = ReminderModel(
      id: _editId ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      type: _type,
      hour: _time.hour,
      minute: _time.minute,
      repeatDays: _repeatDays,
    );

    if (_isEditing) {
      provider.updateReminder(_editId!, reminder);
    } else {
      provider.addReminder(reminder);
    }
    Navigator.pop(context);
  }

  void _toggleDay(int day) {
    setState(() {
      if (_repeatDays.contains(day)) {
        if (_repeatDays.length > 1) _repeatDays.remove(day);
      } else {
        _repeatDays.add(day);
      }
      _repeatDays.sort();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Reminder' : 'Add Reminder')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Reminder Title', prefixIcon: Icon(Icons.title)),
            ),
            SizedBox(height: 20),

            // Type
            Text('Reminder Type', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Row(
              children: [
                _typeChip('meal', 'Meal', Icons.restaurant),
                SizedBox(width: 8),
                _typeChip('water', 'Water', Icons.water_drop),
                SizedBox(width: 8),
                _typeChip('weigh_in', 'Weigh-in', Icons.monitor_weight),
              ],
            ),
            SizedBox(height: 20),

            // Time
            Text('Time', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: _time);
                if (picked != null) setState(() => _time = picked);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primary),
                    SizedBox(width: 12),
                    Text(_time.format(context), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Repeat Days
            Text('Repeat Days', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dayChip(1, 'M'), _dayChip(2, 'T'), _dayChip(3, 'W'),
                _dayChip(4, 'T'), _dayChip(5, 'F'), _dayChip(6, 'S'), _dayChip(7, 'S'),
              ],
            ),
            SizedBox(height: 32),

            CustomButton(text: _isEditing ? 'Update' : 'Save Reminder', onPressed: _save, icon: Icons.check),
          ],
        ),
      ),
    );
  }

  Widget _typeChip(String value, String label, IconData icon) {
    final isSelected = _type == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[300]!),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : Colors.grey, size: 22),
              SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 12, color: isSelected ? AppColors.primary : Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayChip(int day, String label) {
    final isSelected = _repeatDays.contains(day);
    return GestureDetector(
      onTap: () => _toggleDay(day),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: isSelected ? AppColors.primary : Colors.grey[200],
        child: Text(label, style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontWeight: FontWeight.w600,
          fontSize: 12,
        )),
      ),
    );
  }
}
