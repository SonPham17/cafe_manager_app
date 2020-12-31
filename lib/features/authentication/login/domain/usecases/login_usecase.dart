import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';
import 'package:cafe_manager_app/features/authentication/login/domain/repositories/login_repository.dart';

class LoginUseCase{
  final LoginRepository loginRepository;

  LoginUseCase({this.loginRepository});

  Future<String> checkLogin() async{
    final data = await loginRepository.checkLogin();
    return data;
  }

  Future<UserLoginModel> loginWithManager(String userName,String password) async{
    return loginRepository.loginWithManager(userName, password);
  }

  Future<UserLoginModel> loginWithChef(String userName,String password) async{
    return loginRepository.loginWithChef(userName, password);
  }

  Future<UserLoginModel> loginWithWaiter(String userName,String password) async{
    return loginRepository.loginWithWaiter(userName, password);
  }
}