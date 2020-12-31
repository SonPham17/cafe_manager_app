import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MainHomeRepository {
  Stream<QuerySnapshot> getStreamListChef();

  Stream<QuerySnapshot> getStreamListWaiter();

  Future<bool> addNewChef(
      String userLogin,
    String password,
    String fullName,
    String dateOfBirth,
    String gender,
    String phone,
    String address,
  );

  Future<bool> deleteChef(String id);
}
