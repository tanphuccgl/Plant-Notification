import 'package:plant_notification/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static late SharedPreferences _prefs;

  static const String _keyUser = "user";

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveUser(WUser user) {
    _prefs.setString(_keyUser, user.toJson());
  }

  WUser? getUser() => _prefs.getString(_keyUser) != null
      ? WUser.fromJson(_prefs.getString(_keyUser)!)
      : null;
}
