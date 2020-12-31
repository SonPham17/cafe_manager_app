import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/widgets/dialog_question.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:cafe_manager_app/features/main_home/presentation/widgets/item_list_model_widget.dart';
import 'package:cafe_manager_app/features/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
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
        actions: [
          UserManager.instance.getUserLoginType() == LoginType.manager
              ? IconButton(
                  icon: Icon(Icons.person_add),
                  onPressed: () {
                    Routes.instance.navigateTo(RouteName.createChef);
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
                        onTap: () {},
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
                      name: document.data()['name'],
                      image: ImageConstants.cooking,
                      login: document.data()['login'],
                      age: document.data()['age'].toString(),
                      phone: document.data()['phone'],
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
