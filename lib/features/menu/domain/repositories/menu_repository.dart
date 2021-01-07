
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MenuRepository{
  Future<bool> addTypeMenu(String type);
  Future<bool> addDrink(int idTypeMenu, String urlImage, String drinkName, String price);
  Stream<QuerySnapshot> getStreamListTypeMenu();
}