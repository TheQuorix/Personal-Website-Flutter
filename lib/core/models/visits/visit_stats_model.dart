import 'package:personal_website/core/models/visits/daily_visit_model.dart';

class VisitStatsModel {
  final int totalVisits;
  final int uniqueVisits;
  final List<DailyVisitModel> dailyVisits;

  VisitStatsModel({
    required this.totalVisits,
    required this.uniqueVisits,
    required this.dailyVisits,
  });

  factory VisitStatsModel.fromJson(Map<String, dynamic> json) {
    return VisitStatsModel(
      totalVisits: json['total_visits'] as int,
      uniqueVisits: json['unique_visits'] as int,
      dailyVisits: (json['daily'] as List<dynamic>)
          .map((e) => DailyVisitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
