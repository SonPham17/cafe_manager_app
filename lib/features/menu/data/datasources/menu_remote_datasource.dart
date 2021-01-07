import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRemoteDataSource {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getStreamListTypeMenu() {
    CollectionReference menuType =
        _firebaseFireStore.collection(FirebaseCollectionConstants.menuType);
    return menuType.snapshots();
  }

  Future<bool> addDrink(
      int idTypeMenu, String urlImage, String drinkName, String price) async {
    CollectionReference drink = _firebaseFireStore.collection('$idTypeMenu');

    return drink
        .add({
          'idType': idTypeMenu,
          'name': drinkName,
          'price': price,
          'image': urlImage,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addTypeMenu(String type) async {
    CollectionReference menuType =
        _firebaseFireStore.collection(FirebaseCollectionConstants.menuType);

    final checkIsExist = await menuType.where('type', isEqualTo: type).get();

    final instanceMenuType = await menuType.get();
    if (checkIsExist.docs.isEmpty) {
      return menuType
          .add({
            'id': instanceMenuType.size,
            'type': type,
          })
          .then((value) => true)
          .catchError((error) => false);
    } else {
      return false;
    }
  }
}
