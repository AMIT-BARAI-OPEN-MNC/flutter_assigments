import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box('appBox');

  static bool get isLoggedIn => _box.get('isLoggedIn', defaultValue: false);

  static void setLoginState(bool value) {
    _box.put('isLoggedIn', value);
  }
}
