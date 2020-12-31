import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';

abstract class LoginRepository{
  Future<String> checkLogin();
  Future<UserLoginModel> loginWithManager(String userName,String password);
  Future<UserLoginModel> loginWithChef(String userName,String password);
  Future<UserLoginModel> loginWithWaiter(String userName,String password);
}