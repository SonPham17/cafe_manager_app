import 'package:cafe_manager_app/features/main_home/domain/repositories/main_home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainHomeUseCase{
  final MainHomeRepository mainHomeRepository;

  MainHomeUseCase({this.mainHomeRepository});

  Stream<QuerySnapshot> getStreamListChef(){
    return mainHomeRepository.getStreamListChef();
  }

  Stream<QuerySnapshot> getStreamListWaiter(){
    return mainHomeRepository.getStreamListWaiter();
  }

  Future<bool> addNewChef({String userLogin,
    String password,
    String fullName,
    String dateOfBirth,
    String gender,
    String phone,
    String address}){
      return mainHomeRepository.addNewChef(userLogin,password, fullName, dateOfBirth, gender, phone, address);
  }

  Future<bool> deleteChef(String id){
    return mainHomeRepository.deleteChef(id);
  }
}