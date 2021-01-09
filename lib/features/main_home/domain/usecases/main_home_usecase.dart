import 'package:cafe_manager_app/features/main_home/domain/repositories/main_home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainHomeUseCase {
  final MainHomeRepository mainHomeRepository;

  MainHomeUseCase({this.mainHomeRepository});

  Stream<QuerySnapshot> getStreamListChef() {
    return mainHomeRepository.getStreamListChef();
  }

  Stream<QuerySnapshot> getStreamListWaiter() {
    return mainHomeRepository.getStreamListWaiter();
  }

  Future<bool> addNewChef(
      {String userLogin,
      String password,
      String firstName,
      String image,
      String lastName,
      String email,
      String dateOfBirth,
      String gender,
      String phone,
      String address}) {
    return mainHomeRepository.addNewChef(image, userLogin, password, firstName,
        lastName, email, dateOfBirth, gender, phone, address);
  }

  Future<bool> addNewWaiter(
      {String userLogin,
      String image,
      String password,
      String firstName,
      String lastName,
      String email,
      String dateOfBirth,
      String gender,
      String phone,
      String address}) {
    return mainHomeRepository.addNewWaiter(image, userLogin, password,
        firstName, lastName, email, dateOfBirth, gender, phone, address);
  }

  Future<bool> deleteChef(String id) {
    return mainHomeRepository.deleteChef(id);
  }

  Future<bool> deleteWaiter(String id) {
    return mainHomeRepository.deleteWaiter(id);
  }
}
