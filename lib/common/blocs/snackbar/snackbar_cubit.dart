import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarCubit extends Cubit<SnackBarState> {
  SnackBarCubit() : super(SnackBarInitialState());

  void showSnackBar(String msg) {
    emit(ShowSnackBarState(msg: msg));
  }
}
