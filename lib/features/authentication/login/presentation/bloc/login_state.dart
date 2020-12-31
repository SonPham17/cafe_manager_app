import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';

abstract class LoginState{
  bool isSuccess;

  LoginState({this.isSuccess = false});
}

class LoginInitialState extends LoginState{}

class ValidateSuccessState extends LoginState{
  ValidateSuccessState({bool isSuccess}) : super(isSuccess: isSuccess);
}

class LoginSuccessState extends LoginState{
  UserLoginModel userLoginModel;

  LoginSuccessState({this.userLoginModel});
}

class LoginFailedState extends LoginState{}