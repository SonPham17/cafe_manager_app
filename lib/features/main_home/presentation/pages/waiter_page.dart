import 'dart:ui';

import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/common/utils/screen_utils.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:cafe_manager_app/features/main_home/presentation/widgets/item_list_model_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class WaiterPage extends StatefulWidget {
  @override
  _WaiterPageState createState() => _WaiterPageState();
}

class _WaiterPageState extends State<WaiterPage> {
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
        title: Text('Bồi bàn'),
        actions: [
          UserManager.instance.getUserLoginType() == LoginType.manager
              ? IconButton(
                  icon: Icon(Icons.person_add),
                  onPressed: () {},
                )
              : Container()
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _mainHomeCubit.streamListWaiter(),
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
                    return ItemListModel(
                      name: document.data()['name'],
                      image: ImageConstants.waiter,
                      login: document.data()['login'],
                      age: document.data()['age'].toString(),
                      phone: document.data()['phone'],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
