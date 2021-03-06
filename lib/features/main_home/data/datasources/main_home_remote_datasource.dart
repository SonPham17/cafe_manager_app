import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainHomeRemoteDataSource {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllListChef() {
    CollectionReference chefs =
        _firebaseFireStore.collection(FirebaseCollectionConstants.chef);
    return chefs.snapshots();
  }

  Stream<QuerySnapshot> getAllListWaiter() {
    CollectionReference waiters =
        _firebaseFireStore.collection(FirebaseCollectionConstants.waiter);
    return waiters.snapshots();
  }

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
      String address) async {
    CollectionReference chefs =
        _firebaseFireStore.collection(FirebaseCollectionConstants.chef);

    final checkIsExist =
        await chefs.where('userLogin', isEqualTo: userLogin).get();
    if (checkIsExist.docs.isEmpty) {
      return chefs
          .add({
            'image': image,
            'userLogin': userLogin,
            'password': password,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'dateOfBirth': dateOfBirth,
            'gender': gender,
            'phone': phone,
            'address': address,
          })
          .then((value) => true)
          .catchError((error) => false);
    } else {
      return false;
    }
  }

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
      String address) async {
    CollectionReference chefs =
    _firebaseFireStore.collection(FirebaseCollectionConstants.waiter);

    final checkIsExist =
    await chefs.where('userLogin', isEqualTo: userLogin).get();
    if (checkIsExist.docs.isEmpty) {
      return chefs
          .add({
        'image' : image,
        'userLogin': userLogin,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phone': phone,
        'address': address,
      })
          .then((value) => true)
          .catchError((error) => false);
    } else {
      return false;
    }
  }

  Future<bool> deleteChef(String id) {
    CollectionReference chefs =
        _firebaseFireStore.collection(FirebaseCollectionConstants.chef);

    return chefs
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteWaiter(String id) {
    CollectionReference chefs =
    _firebaseFireStore.collection(FirebaseCollectionConstants.waiter);

    return chefs
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
