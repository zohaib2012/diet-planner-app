class WaterLog {
  String id;
  DateTime date;
  int glassCount;
  int goalGlasses;
  int glassSizeMl;

  WaterLog({
    required this.id,
    required this.date,
    this.glassCount = 0,
    this.goalGlasses = 8,
    this.glassSizeMl = 250,
  });

  int get totalMl => glassCount * glassSizeMl;
  double get progress => goalGlasses > 0 ? glassCount / goalGlasses : 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'glassCount': glassCount,
      'goalGlasses': goalGlasses,
      'glassSizeMl': glassSizeMl,
    };
  }

  factory WaterLog.fromMap(Map<String, dynamic> map) {
    return WaterLog(
      id: map['id'],
      date: DateTime.parse(map['date']),
      glassCount: map['glassCount'],
      goalGlasses: map['goalGlasses'] ?? 8,
      glassSizeMl: map['glassSizeMl'] ?? 250,
    );
  }
}
