import 'package:mobile/app/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorageService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final String _userDataKey = 'userDataKey';

  Future<UserModel> getUserData() async {
    final prefs = await _prefs;
    final String userStringData = prefs.getString(_userDataKey);
    if (userStringData == null) {
      return null;
    } else {
      return UserModel.fromJson(userStringData);
    }
  }

  Future<void> setUserData(UserModel userData) async {
    final prefs = await _prefs;
    await prefs.setString(_userDataKey, userData.toJson());
  }

  Future<void> clearUserData() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
