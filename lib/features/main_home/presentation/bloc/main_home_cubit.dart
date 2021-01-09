import 'dart:io';
import 'dart:math';

import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/features/main_home/domain/usecases/main_home_usecase.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_state.dart';
import 'package:cafe_manager_app/features/menu/data/models/menu_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeUseCase mainHomeUseCase;
  SnackBarCubit snackBarCubit;
  LoadingCubit loadingCubit;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  MainHomeCubit({this.mainHomeUseCase, this.snackBarCubit, this.loadingCubit})
      : super(MainHomeInitialState());

  Stream<QuerySnapshot> streamListChef() {
    return mainHomeUseCase.getStreamListChef();
  }

  Stream<QuerySnapshot> streamListWaiter() {
    return mainHomeUseCase.getStreamListWaiter();
  }

  void tangOrder(List<MenuDrink> dataMenuDrink) {
    var soMon = 0;
    var soTien = 0;
    var monOrder = '';
    dataMenuDrink.forEach((element) {
      if (element.order > 0) {
        soMon = soMon + 1;
        soTien = soTien + (int.parse(element.price) * element.order);
        monOrder = monOrder + '${element.name} x${element.order}, ';
      }
    });

    emit(IncrementOrderState(
      soTien: soTien,
      soMon: soMon,
      monOrder: monOrder.substring(0, monOrder.length - 2),
    ));
  }

  void resetState(){
    state.soMon = 0;
    state.monOrder = '';
    state.soTien = 0;
  }

  void giamOrder(List<MenuDrink> dataMenuDrink) {
    var soMon = 0;
    var soTien = 0;
    var monOrder = '';
    dataMenuDrink.forEach((element) {
      if (element.order > 0) {
        soMon = soMon + 1;
        soTien = soTien + (int.parse(element.price) * element.order);
        monOrder = monOrder + '${element.name} x${element.order}';
      }
    });

    emit(DecrementOrderState(
      soTien: soTien,
      soMon: soMon,
      monOrder: monOrder,
    ));
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  String _rdStr(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> createUserChef(
      {String userLogin,
      File image,
      String password,
      String firstName,
      String lastName,
      String email,
      String dateOfBirth,
      Gender gender,
      String phone,
      String address}) async {
    loadingCubit.showLoading(true);
    if (userLogin.isEmpty &&
        password.isEmpty &&
        firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
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

      var linkPath;
      if (image != null) {
        String fileName = basename(image.path);
        Reference firebaseStorageRef = FirebaseStorage
            .instance
            .ref()
            .child('uploads/${_rdStr(15)}');
        UploadTask uploadTask =
        firebaseStorageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;

        linkPath =
        await taskSnapshot.ref.getDownloadURL();
      }

      final isSuccess = await mainHomeUseCase.addNewChef(
          userLogin: userLogin,
          password: password,
          firstName: firstName,
          image: linkPath,
          lastName: lastName,
          email: email,
          dateOfBirth: dateOfBirth,
          gender: gioiTinh,
          phone: phone,
          address: address);

      if (isSuccess) {
        emit(AddSuccessState());
        snackBarCubit.showSnackBar('Tạo đầu bếp mới thành công!');
      } else {
        emit(AddFailedState());
        snackBarCubit.showSnackBar('Tên tài khoản đã tồn tại!');
      }
    }
    loadingCubit.showLoading(false);
  }

  Future<void> createUserWaiter(
      {String userLogin,
      String password,
      File image,
      String firstName,
      String lastName,
      String email,
      String dateOfBirth,
      Gender gender,
      String phone,
      String address}) async {
    loadingCubit.showLoading(true);
    if (userLogin.isEmpty &&
        password.isEmpty &&
        firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
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

      var linkPath;
      if (image != null) {
        String fileName = basename(image.path);
        Reference firebaseStorageRef = FirebaseStorage
            .instance
            .ref()
            .child('uploads/${_rdStr(15)}');
        UploadTask uploadTask =
        firebaseStorageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;

        linkPath =
        await taskSnapshot.ref.getDownloadURL();
      }

      final isSuccess = await mainHomeUseCase.addNewWaiter(
          userLogin: userLogin,
          image: linkPath,
          password: password,
          firstName: firstName,
          lastName: lastName,
          email: email,
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

  Future<void> updateUser({String password,
    String firstName,
    String lastName,
    String email,
    String dateOfBirth,
    Gender gender,
    String phone,
    String address,
    String id,
    String typeEdit}) async {
    loadingCubit.showLoading(true);
    if (password.isEmpty &&
        firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
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

      CollectionReference user = _firebaseFireStore.collection(typeEdit);

      await user.doc(id).update({
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gioiTinh,
        'phone': phone,
        'address': address,
      }).then((value) {
        snackBarCubit.showSnackBar('Cập nhật thông tin thành công!');
      }).catchError((error) {
        snackBarCubit.showSnackBar('Cập nhật thông tin thất bại!');
      });
    }
    loadingCubit.showLoading(false);
  }

  Future<void> deleteChef(String id) async {
    loadingCubit.showLoading(true);
    final result = await mainHomeUseCase.deleteChef(id);
    if (result) {
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thành công!');
    } else {
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thất bại!');
    }
  }

  Future<void> deleteWaiter(String id) async {
    loadingCubit.showLoading(true);
    final result = await mainHomeUseCase.deleteWaiter(id);
    if (result) {
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thành công!');
    } else {
      loadingCubit.showLoading(false);
      snackBarCubit.showSnackBar('Xoá thất bại!');
    }
  }
}
