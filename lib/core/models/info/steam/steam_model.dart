import 'package:personal_website/core/models/info/steam/steam_game_model.dart';

class SteamModel {
  final List<SteamGameModel> recent;
  final List<SteamGameModel> top;

  SteamModel({required this.recent, required this.top});

  factory SteamModel.fromJson(Map<String, dynamic> json) {
    return SteamModel(
      recent: (json['recent'] as List<dynamic>)
          .map((e) => SteamGameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      top: (json['top'] as List<dynamic>)
          .map((e) => SteamGameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
