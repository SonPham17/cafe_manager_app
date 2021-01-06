
import 'package:cafe_manager_app/features/menu/domain/repositories/menu_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuUseCase{
  final MenuRepository menuRepository;

  MenuUseCase({this.menuRepository});

  Stream<QuerySnapshot> getStreamListTypeMenu() {
    return menuRepository.getStreamListTypeMenu();
  }

  Future<bool> addTypeMenu(String type){
    return menuRepository.addTypeMenu(type);
  }
}