import 'package:flutter/foundation.dart';
import 'package:personal_website/services/local_storage_service.dart';

class WatchedButtonsController extends ChangeNotifier {
  static const keyAboutMe = 'watched_about_me';
  static const keyGithub = 'watched_github';
  static const keyMusic = 'watched_music';
  static const keySystemInfo = 'watched_system_info';
  static const keyGameActivity = 'watched_game_activity';
  static const keyUltrakill = 'watched_ultrakill';

  final Map<String, bool> _watched = {
    keyAboutMe: true,
    keyGithub: false,
    keyMusic: false,
    keySystemInfo: false,
    keyGameActivity: false,
    keyUltrakill: false,
  };

  bool isWatched(String key) => _watched[key] ?? false;

  Future<void> load() async {
    final entries = await Future.wait(
      _watched.keys.map((key) async {
        final value = await LocalStorageService.getBool(
          key,
          defaultValue: _watched[key]!,
        );
        return MapEntry(key, value);
      }),
    );
    _watched.addEntries(entries);
    notifyListeners();
  }

  Future<void> markWatched(String key) async {
    if (_watched[key] == true) return;
    _watched[key] = true;
    notifyListeners();
    await LocalStorageService.saveBool(key, true);
  }
}
