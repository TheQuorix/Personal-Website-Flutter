import 'package:personal_website/core/models/info/github/github_model.dart';
import 'package:personal_website/core/models/info/music/music_model.dart';
import 'package:personal_website/core/models/info/steam/steam_model.dart';
import 'package:personal_website/core/models/info/weather/weather_model.dart';

class InfoModel {
  final WeatherModel weather;
  final MusicModel music;
  final SteamModel steam;
  final GithubModel github;

  InfoModel({
    required this.weather,
    required this.music,
    required this.steam,
    required this.github,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      weather: WeatherModel.fromJson(json['weather'] as Map<String, dynamic>),
      music: MusicModel.fromJson(json['music'] as Map<String, dynamic>),
      steam: SteamModel.fromJson(json['steam'] as Map<String, dynamic>),
      github: GithubModel.fromJson(json['github'] as Map<String, dynamic>),
    );
  }
}
