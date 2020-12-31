import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/features/authentication/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  Future<void> checkUserIsLogin() async {
    final user = await UserManager.instance.getUserLogin();
    if (user == null) {
      emit(UserNotLoginState());
    } else {
      emit(UserLoggedState(userLoginModel: user));
    }
  }
}
