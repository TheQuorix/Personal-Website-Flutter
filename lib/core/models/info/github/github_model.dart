import 'package:personal_website/core/models/info/github/github_week_model.dart';

class GithubModel {
  final int followers;
  final int repos;
  final int contributions;
  final List<GithubWeekModel> calendar;

  GithubModel({
    required this.followers,
    required this.repos,
    required this.contributions,
    required this.calendar,
  });

  factory GithubModel.fromJson(Map<String, dynamic> json) {
    return GithubModel(
      followers: json['followers'] as int,
      repos: json['repos'] as int,
      contributions: json['contributions'] as int,
      calendar: (json['calendar'] as List<dynamic>)
          .map((e) => GithubWeekModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
