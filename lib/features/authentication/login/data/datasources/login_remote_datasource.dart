import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/features/authentication/login/data/models/user_login_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRemoteDataSource {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<UserLoginModel> loginWithManager(String userName, String password) async {
    CollectionReference managers =
        _firebaseFireStore.collection(FirebaseCollectionConstants.manage);

    final snapShot = await managers.where('login',isEqualTo: userName).get();
    return snapShot.docs.isEmpty ? null : UserLoginModel.fromJson(snapShot.docs.first.data(),LoginType.manager);
  }

  Future<UserLoginModel> loginWithChef(String userName, String password) async {
    CollectionReference chefs =
    _firebaseFireStore.collection(FirebaseCollectionConstants.chef);

    final snapShot = await chefs.where('login',isEqualTo: userName).get();
    return snapShot.docs.isEmpty ? null : UserLoginModel.fromJson(snapShot.docs.first.data(),LoginType.chef);
  }

  Future<UserLoginModel> loginWithWaiter(String userName, String password) async {
    CollectionReference waiters =
    _firebaseFireStore.collection(FirebaseCollectionConstants.waiter);

    final snapShot = await waiters.where('login',isEqualTo: userName).get();
    return snapShot.docs.isEmpty ? null : UserLoginModel.fromJson(snapShot.docs.first.data(),LoginType.waiter);
  }
}
