
import 'package:cafe_manager_app/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:cafe_manager_app/features/menu/domain/repositories/menu_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepositoryImpl extends MenuRepository{
  MenuRemoteDataSource menuRemoteDataSource;

  MenuRepositoryImpl({this.menuRemoteDataSource});

  @override
  Future<bool> addTypeMenu(String type) {
    return menuRemoteDataSource.addTypeMenu(type);
  }

  @override
  Stream<QuerySnapshot> getStreamListTypeMenu() {
    return menuRemoteDataSource.getStreamListTypeMenu();
  }

}