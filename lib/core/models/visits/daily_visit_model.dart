class DailyVisitModel {
  final DateTime date;
  final int total;
  final int unique;

  DailyVisitModel({
    required this.date,
    required this.total,
    required this.unique,
  });

  factory DailyVisitModel.fromJson(Map<String, dynamic> json) {
    return DailyVisitModel(
      date: DateTime.parse(json['date'] as String),
      total: json['total'] as int,
      unique: json['unique'] as int,
    );
  }
}
