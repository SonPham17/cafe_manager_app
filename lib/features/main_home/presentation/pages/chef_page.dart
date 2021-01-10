import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/widgets/dialog_question.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:cafe_manager_app/features/main_home/presentation/widgets/item_list_model_widget.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class ChefPage extends StatefulWidget {
  @override
  _ChefPageState createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> {
  MainHomeCubit _mainHomeCubit;

  @override
  void initState() {
    super.initState();

    _mainHomeCubit = Injector.resolve<MainHomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đầu bếp'),
        centerTitle: true,
        actions: [
          UserManager.instance.getUserLoginType() == LoginType.manager
              ? IconButton(
                  icon: Icon(Icons.person_add),
                  onPressed: () {
                    RoutesTabBottom.instance.navigateTo(
                        TabItem.main, RouteName.createChef,
                        arguments: 'chef');
                  },
                )
              : Container()
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _mainHomeCubit.streamListChef(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 30.sp),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  child: Lottie.asset('assets/gifs/loading_gif.json',
                      width: 80, height: 80),
                ),
              );
            }

            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text('Dữ liệu đang trống!'),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Sửa',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () {
                          RoutesTabBottom.instance.navigateTo(
                              TabItem.main, RouteName.tabEditProfile,
                              arguments: {
                                'type': FirebaseCollectionConstants.chef,
                                'id': document.id,
                                'image': document.data()['image'],
                                'address': document.data()['address'],
                                'dateOfBirth': document.data()['dateOfBirth'],
                                'phone': document.data()['phone'],
                                'email': document.data()['email'],
                                'firstName': document.data()['firstName'],
                                'lastName': document.data()['lastName'],
                                'gender': document.data()['gender'],
                                'password': document.data()['password'],
                              });
                        },
                      ),
                      IconSlideAction(
                        caption: 'Xoá',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => DialogQuestion(
                                id: document.id,
                                isWaiter: false,
                                mainHomeCubit: _mainHomeCubit,
                                i18nLocalizationContent:
                                    'Bạn có muốn xoá thông tin thành viên này không ?',
                                i18nLocalizationConfirmText: 'Đồng ý',
                                i18nLocalizationCancelText: 'Huỷ',
                                i18nLocalizationTitle: 'Xoá nhân viên'),
                          );
                        },
                      ),
                    ],
                    child: ItemListModel(
                      type: 'chef',
                      name:
                          '${document.data()['firstName']} ${document.data()['lastName']}',
                      image: document.data()['image'],
                      login: document.data()['userLogin'],
                      age: document.data()['dateOfBirth'],
                      phone: document.data()['phone'],
                      address: document.data()['address'],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
