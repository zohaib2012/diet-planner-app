class WeightLog {
  String id;
  DateTime date;
  double weightKg;
  double? bmi;

  WeightLog({
    required this.id,
    required this.date,
    required this.weightKg,
    this.bmi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'weightKg': weightKg,
      'bmi': bmi,
    };
  }

  factory WeightLog.fromMap(Map<String, dynamic> map) {
    return WeightLog(
      id: map['id'],
      date: DateTime.parse(map['date']),
      weightKg: (map['weightKg'] as num).toDouble(),
      bmi: (map['bmi'] as num?)?.toDouble(),
    );
  }
}
