import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/features/main_home/data/models/order_model.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách order'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(FirebaseCollectionConstants.order)
              .snapshots(),
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
                  'Hiện chưa có đơn order nào!',
                  style: TextStyle(fontSize: 25.sp),
                ),
              );
            }

            final data = snapshot.data.docs;
            final listData =
                data.map((e) => OrderModel.fromJson(e.data(),e.id)).toList();
            return ListView.separated(
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      RoutesTabBottom.instance.navigateTo(
                          TabItem.main, RouteName.tabDetailOrder,
                          arguments: listData[index]);
                    },
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.primaryColor,
                      child: Container(
                        height: 130.h,
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 5.h, bottom: 5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.h,
                              margin: EdgeInsets.only(right: 20.w),
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                IconConstants.order,
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bàn số: ${listData[index].ban}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Tổng tiền: ${formatter.format(listData[index].tongTien)} vnd',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                  );
                },
                itemCount: listData.length);
          },
        ),
      ),
    );
  }
}
