
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MenuRepository{
  Future<bool> addTypeMenu(String type);
  Stream<QuerySnapshot> getStreamListTypeMenu();
}