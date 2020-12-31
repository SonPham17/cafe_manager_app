import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_state.dart';
import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/common/utils/validate_utils.dart';
import 'package:cafe_manager_app/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/widgets/label_radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginCubit extends Cubit<LoginState> {
  final userNameSubject = BehaviorSubject<String>();
  final passSubject = BehaviorSubject<String>();

  final SnackBarCubit snackBarCubit;
  final LoginUseCase loginUseCase;

  LoginCubit({this.loginUseCase, this.snackBarCubit})
      : super(LoginInitialState());

  void validateForm() {
    Rx.combineLatest2(
        userNameSubject,
        passSubject,
        (userName, pass) =>
            ValidateUtil.validPassword(pass) &&
            ValidateUtil.validUserName(userName)).listen((result) {
      emit(ValidateSuccessState(isSuccess: result));
    });
  }

  Future<void> login(
      {LoginType loginType, String userName, String password}) async {
    switch (loginType) {
      case LoginType.manager:
        final user = await loginUseCase.loginWithManager(userName, password);
        if (user == null) {
          emit(LoginFailedState());
          snackBarCubit.emit(ShowSnackBarState(
              msg: 'Tên đăng nhập hoặc mật khẩu không tồn tại!'));
        } else {
          if (user.password == password) {
            UserManager.instance.saveUserLogin(user);
            emit(LoginSuccessState(userLoginModel: user));
          } else {
            emit(LoginFailedState());
            snackBarCubit.emit(ShowSnackBarState(
                msg: 'Tên đăng nhập hoặc mật khẩu không đúng!'));
          }
        }
        break;
      case LoginType.chef:
        final user = await loginUseCase.loginWithChef(userName, password);
        if (user == null) {
          emit(LoginFailedState());
          snackBarCubit.emit(ShowSnackBarState(
              msg: 'Tên đăng nhập hoặc mật khẩu không tồn tại!'));
        } else {
          if (user.password == password) {
            UserManager.instance.saveUserLogin(user);
            emit(LoginSuccessState(userLoginModel: user));
          } else {
            emit(LoginFailedState());
            snackBarCubit.emit(ShowSnackBarState(
                msg: 'Tên đăng nhập hoặc mật khẩu không đúng!'));
          }
        }
        break;
      case LoginType.waiter:
        final user = await loginUseCase.loginWithWaiter(userName, password);
        if (user == null) {
          emit(LoginFailedState());
          snackBarCubit.emit(ShowSnackBarState(
              msg: 'Tên đăng nhập hoặc mật khẩu không tồn tại!'));
        } else {
          if (user.password == password) {
            UserManager.instance.saveUserLogin(user);
            emit(LoginSuccessState(userLoginModel: user));
          } else {
            emit(LoginFailedState());
            snackBarCubit.emit(ShowSnackBarState(
                msg: 'Tên đăng nhập hoặc mật khẩu không đúng!'));
          }
        }
        break;
    }
  }

  @override
  Future<void> close() {
    userNameSubject.close();
    passSubject.close();

    return super.close();
  }
}
