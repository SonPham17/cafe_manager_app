import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';

abstract class SplashState {
  UserLoginModel userLoginModel;

  SplashState({this.userLoginModel});
}

class SplashInitialState extends SplashState {}

class UserNotLoginState extends SplashState {}

class UserLoggedState extends SplashState {
  UserLoggedState({UserLoginModel userLoginModel})
      : super(userLoginModel: userLoginModel);
}
