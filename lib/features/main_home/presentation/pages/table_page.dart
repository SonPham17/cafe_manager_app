import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/extensions/my_iterable_extensions.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/widgets/dialog_add_table.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:ribbon/ribbon.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bàn'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                showDialog(context: context, builder: (_) => DialogAddTable());
              })
        ],
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: StreamBuilder<QuerySnapshot>(
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
                child: Text(
                  'Chưa có bàn nào trong cửa hàng, hãy tạo thêm bàn để sử dụng chức năng này nhé!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28.sp),
                ),
              );
            }

            var data = snapshot.data.docs;
            data = data.sortedBy((e) => e.data()['id']);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2),
              itemBuilder: (_, index) => data[index]['isEmpty']
                  ? GestureDetector(
                      onTap: () {
                        Injector.resolve<MainHomeCubit>().resetState();

                        RoutesTabBottom.instance.navigateTo(
                            TabItem.main, RouteName.tabOrderTable,
                            arguments: {
                              'id': data[index]['id'],
                              'idBan': data[index].id,
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.4)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              IconConstants.tableOrder,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              'Bàn ${1 + data[index]['id']}',
                              style: TextStyle(
                                  fontSize: 30.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Ribbon(
                      nearLength: 60,
                      farLength: 12,
                      title: 'Order',
                      titleStyle: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      color: Colors.redAccent,
                      location: RibbonLocation.topStart,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.4)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              IconConstants.tableOrder,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              'Bàn ${1 + data[index]['id']}',
                              style: TextStyle(
                                  fontSize: 30.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
              itemCount: snapshot.data.size,
            );
          },
          stream: FirebaseFirestore.instance
              .collection(FirebaseCollectionConstants.table)
              .snapshots(),
        ),
      ),
    );
  }
}
