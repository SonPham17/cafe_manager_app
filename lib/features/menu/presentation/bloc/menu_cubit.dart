import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/features/menu/domain/usecases/menu_usecase.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MenuCubit extends Cubit<MenuState> {
  final SnackBarCubit snackBarCubit;
  final LoadingCubit loadingCubit;

  final MenuUseCase menuUseCase;
  final addTypeMenuSubject = BehaviorSubject<String>();
  final addDrinkMenuSubject = BehaviorSubject<String>();
  final addPriceMenuSubject = BehaviorSubject<String>();

  MenuCubit({this.menuUseCase, this.snackBarCubit, this.loadingCubit})
      : super(MenuInitialState());

  Stream<QuerySnapshot> streamListTypeMenu() {
    return menuUseCase.getStreamListTypeMenu();
  }

  Future<void> addTypeMenu(String type) async {
    loadingCubit.showLoading(true);
    final result = await menuUseCase.addTypeMenu(type);
    loadingCubit.showLoading(false);
    if (result) {
      snackBarCubit.showSnackBar('Thêm thành công!');
    } else {
      snackBarCubit.showSnackBar('Thêm thất bại (Có thể loại này đã tồn tại)');
    }
  }

  Future<void> addDrink(
      int idTypeMenu, String urlImage, String drinkName, String price) async {
    final result =
        await menuUseCase.addDrink(idTypeMenu, urlImage, drinkName, price);
    loadingCubit.showLoading(false);
    if (result) {
      snackBarCubit.showSnackBar('Thêm thành công!');
    } else {
      snackBarCubit.showSnackBar('Thêm thất bại!');
    }
  }

  @override
  Future<void> close() {
    addTypeMenuSubject.close();
    addDrinkMenuSubject.close();
    addPriceMenuSubject.close();
    return super.close();
  }
}
