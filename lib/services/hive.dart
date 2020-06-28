import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class UserProvider {
  static Future<LazyBox> _getBox() async {
    await Hive.initFlutter();
    final box = await Hive.openLazyBox("user");
    return box;
  }

  static Future<void> saveUserId(String id) async {
    final _box = await _getBox();
    await _box.put("user_id", id);
  }

  static Future<String> fetchUserId() async {
    final _box = await _getBox();
    return await _box.get('user_id');
  }

  static Future<bool> get isLoggedIn async {
    final _id = await fetchUserId();
    return _id != null;
  }
}
