import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/game_constants.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  int get highScore => _box.read<int>(GameConstants.keyHighScore) ?? 0;
  Future<void> saveHighScore(int score) async {
    if (score > highScore) {
      await _box.write(GameConstants.keyHighScore, score);
    }
  }

  Future<void> resetHighScore() async {
    await _box.write(GameConstants.keyHighScore, 0);
  }

  bool get isSfxEnabled => _box.read<bool>(GameConstants.keySfxEnabled) ?? true;
  Future<void> setSfxEnabled(bool value) async {
    await _box.write(GameConstants.keySfxEnabled, value);
  }

  bool get isMusicEnabled => _box.read<bool>(GameConstants.keyMusicEnabled) ?? true;
  Future<void> setMusicEnabled(bool value) async {
    await _box.write(GameConstants.keyMusicEnabled, value);
  }

  int get totalGames => _box.read<int>(GameConstants.keyTotalGames) ?? 0;
  Future<void> incrementTotalGames() async {
    await _box.write(GameConstants.keyTotalGames, totalGames + 1);
  }
}
