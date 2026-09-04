class SteamGameModel {
  final int appId;
  final String name;
  final String iconUrl;
  final int playtime2Weeks;
  final int playtimeForever;

  SteamGameModel({
    required this.appId,
    required this.name,
    required this.iconUrl,
    required this.playtime2Weeks,
    required this.playtimeForever,
  });

  factory SteamGameModel.fromJson(Map<String, dynamic> json) {
    return SteamGameModel(
      appId: json['app_id'] as int,
      name: json['name'] as String,
      iconUrl: json['icon_url'] as String,
      playtime2Weeks: json['playtime_2weeks'] as int,
      playtimeForever: json['playtime_forever'] as int,
    );
  }
}
