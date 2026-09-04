import 'package:personal_website/core/models/info/github/github_day_model.dart';

class GithubWeekModel {
  final List<GithubDayModel> days;

  GithubWeekModel({required this.days});

  factory GithubWeekModel.fromJson(Map<String, dynamic> json) {
    return GithubWeekModel(
      days: (json['days'] as List<dynamic>)
          .map((e) => GithubDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
