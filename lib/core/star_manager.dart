import 'package:shared_preferences/shared_preferences.dart';

class StarManager {
  static const _key = 'stars_total';

  static Future<int> getStars() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_key) ?? 0;
  }

  static Future<void> addStars(int value) async {
    final p = await SharedPreferences.getInstance();
    final current = p.getInt(_key) ?? 0;
    await p.setInt(_key, current + value);
  }

  static Future<void> resetStars() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key, 0);
  }
}
