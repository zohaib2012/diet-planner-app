class ReminderModel {
  String id;
  String title;
  String type; // meal, water, weigh_in
  int hour;
  int minute;
  List<int> repeatDays; // 1=Mon, 7=Sun
  bool isActive;

  ReminderModel({
    required this.id,
    required this.title,
    required this.type,
    required this.hour,
    required this.minute,
    required this.repeatDays,
    this.isActive = true,
  });

  String get timeString {
    final h = hour > 12 ? hour - 12 : hour;
    final amPm = hour >= 12 ? 'PM' : 'AM';
    return '${h.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm';
  }

  String get daysString {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (repeatDays.length == 7) return 'Every day';
    if (repeatDays.length == 5 && !repeatDays.contains(6) && !repeatDays.contains(7)) {
      return 'Weekdays';
    }
    return repeatDays.map((d) => dayNames[d - 1]).join(', ');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'hour': hour,
      'minute': minute,
      'repeatDays': repeatDays,
      'isActive': isActive,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      hour: map['hour'],
      minute: map['minute'],
      repeatDays: List<int>.from(map['repeatDays']),
      isActive: map['isActive'] ?? true,
    );
  }
}
