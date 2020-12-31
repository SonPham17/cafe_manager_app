import 'package:cafe_manager_app/common/extensions/string_extensions.dart';

class ValidateUtil{
  static bool validPassword(String password) {
    if (password.isEmptyOrNull) {
      return false;
    }
    return true;
  }

  static bool validUserName(String fullname) {
    if (fullname.isEmptyOrNull) {
      return false;
    }
    return true;
  }
}