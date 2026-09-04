class GithubDayModel {
  final DateTime date;
  final int count;
  final int level;

  GithubDayModel({
    required this.date,
    required this.count,
    required this.level,
  });

  factory GithubDayModel.fromJson(Map<String, dynamic> json) {
    return GithubDayModel(
      date: DateTime.parse(json['date'] as String),
      count: json['count'] as int,
      level: json['level'] as int,
    );
  }
}
