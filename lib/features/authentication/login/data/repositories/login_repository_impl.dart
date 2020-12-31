import 'package:cafe_manager_app/features/authentication/login/data/datasources/login_local_datasource.dart';
import 'package:cafe_manager_app/features/authentication/login/data/datasources/login_remote_datasource.dart';
import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';
import 'package:cafe_manager_app/features/authentication/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository{
  LoginLocalDataSource localDataSource;
  LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({this.localDataSource,this.remoteDataSource});

  @override
  Future<String> checkLogin() async{
    final data = await localDataSource.checkLogin();
    return data;
  }

  @override
  Future<UserLoginModel> loginWithManager(String userName, String password) async{
    return remoteDataSource.loginWithManager(userName, password);
  }

  @override
  Future<UserLoginModel> loginWithChef(String userName, String password) {
    return remoteDataSource.loginWithChef(userName, password);
  }

  @override
  Future<UserLoginModel> loginWithWaiter(String userName, String password) {
    return remoteDataSource.loginWithWaiter(userName, password);
  }

}