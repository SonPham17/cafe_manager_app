import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/features/main_home/domain/usecases/main_home_usecase.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeUseCase mainHomeUseCase;
  SnackBarCubit snackBarCubit;
  LoadingCubit loadingCubit;

  MainHomeCubit({this.mainHomeUseCase, this.snackBarCubit, this.loadingCubit})
      : super(MainHomeInitialState());

  Stream<QuerySnapshot> streamListChef() {
    return mainHomeUseCase.getStreamListChef();
  }

  Stream<QuerySnapshot> streamListWaiter() {
    return mainHomeUseCase.getStreamListWaiter();
  }

  Future<void> createUserChef(
      {String userLogin,
      String password,
      String fullName,
      String dateOfBirth,
      Gender gender,
      String phone,
      String address}) async {
    loadingCubit.showLoading(true);
    if (userLogin.isEmpty &&
        password.isEmpty &&
        fullName.isEmpty &&
        dateOfBirth.isEmpty &&
        phone.isEmpty &&
        address.isEmpty) {
      snackBarCubit.showSnackBar('Vui lòng nhập đủ các trường!');
    } else {
      var gioiTinh = '';
      switch (gender) {
        case Gender.male:
          gioiTinh = 'Nam';
          break;
        case Gender.female:
          gioiTinh = 'Nu';
          break;
      }

      final isSuccess = await mainHomeUseCase.addNewChef(
          userLogin: userLogin,
          password: password,
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          gender: gioiTinh,
          phone: phone,
          address: address);

      if (isSuccess) {
        snackBarCubit.showSnackBar('Tao dau bep moi thanh cong!');
      } else {
        snackBarCubit.showSnackBar('Tên tài khoản đã tồn tại!');
      }

      loadingCubit.showLoading(false);
    }
  }

  Future<void> deleteChef(String id) async{
    loadingCubit.showLoading(true);
    final result = await mainHomeUseCase.deleteChef(id);
    if(result){
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thành công!');
    }else{
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thất bại!');
    }
  }
}
