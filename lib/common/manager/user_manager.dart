import 'dart:convert';

import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  SharedPreferences _prefs;

  UserManager._internal();

  static final UserManager _userManager = UserManager._internal();

  static UserManager get instance => _userManager;

  UserLoginModel userLoginModel;

  Future<UserLoginModel> getUserLogin() async {
    _prefs = await SharedPreferences.getInstance();
    final json = _prefs.getString('user_info');
    if (json != null && json.isNotEmpty) {
      LoginType loginType = LoginType.values
          .firstWhere((e) => e.toString() == jsonDecode(json)['loginType']);

      userLoginModel = UserLoginModel.fromJson(jsonDecode(json), loginType);
      return userLoginModel;
    }
    return null;
  }

  LoginType getUserLoginType() {
    return userLoginModel.loginType;
  }

  Future<void> saveUserLogin(UserLoginModel userLoginModel) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('user_info',
        userLoginModel != null ? jsonEncode(userLoginModel.toMap()) : null);
  }
}
