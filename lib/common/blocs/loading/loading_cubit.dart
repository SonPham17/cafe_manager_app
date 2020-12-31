
import 'package:cafe_manager_app/common/blocs/loading/loading_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitialState());

  void showLoading(bool isShow) {
    emit(ShowLoadingState(isShow: isShow));
  }
}