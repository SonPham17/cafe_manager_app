import 'package:cafe_manager_app/features/main_home/data/datasources/main_home_remote_datasource.dart';
import 'package:cafe_manager_app/features/main_home/domain/repositories/main_home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainHomeRepositoryImpl extends MainHomeRepository {
  MainHomeRemoteDataSource mainHomeRemoteDataSource;

  MainHomeRepositoryImpl({this.mainHomeRemoteDataSource});

  @override
  Stream<QuerySnapshot> getStreamListChef() {
    return mainHomeRemoteDataSource.getAllListChef();
  }

  @override
  Stream<QuerySnapshot> getStreamListWaiter() {
    return mainHomeRemoteDataSource.getAllListWaiter();
  }

  @override
  Future<bool> addNewChef(String userLogin, String password, String fullName,
      String dateOfBirth, String gender, String phone, String address) {
    return mainHomeRemoteDataSource.addNewChef(
        userLogin, password, fullName, dateOfBirth, gender, phone, address);
  }

  @override
  Future<bool> deleteChef(String id) {
    return mainHomeRemoteDataSource.deleteChef(id);
  }
}
