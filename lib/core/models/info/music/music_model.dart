class MusicModel {
  final String artist;
  final String name;
  final String imageUrl;
  final String songUrl;
  final bool nowPlaying;
  final DateTime date;

  MusicModel({
    required this.artist,
    required this.name,
    required this.imageUrl,
    required this.songUrl,
    required this.nowPlaying,
    required this.date,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      artist: json['artist'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      songUrl: json['song_url'] as String,
      nowPlaying: json['now_playing'] as bool,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
