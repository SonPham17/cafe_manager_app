import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MainHomeRepository {
  Stream<QuerySnapshot> getStreamListChef();

  Stream<QuerySnapshot> getStreamListWaiter();

  Future<bool> addNewChef(
    String image,
    String userLogin,
    String password,
    String firstName,
    String lastName,
    String email,
    String dateOfBirth,
    String gender,
    String phone,
    String address,
  );

  Future<bool> addNewWaiter(
    String image,
    String userLogin,
    String password,
    String firstName,
    String lastName,
    String email,
    String dateOfBirth,
    String gender,
    String phone,
    String address,
  );

  Future<bool> deleteChef(String id);
  Future<bool> deleteWaiter(String id);
}
