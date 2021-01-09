import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/widgets/dialog_confirm_done_order.dart';
import 'package:cafe_manager_app/features/main_home/data/models/order_model.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class DetailOrderPage extends StatefulWidget {
  final OrderModel orderModel;

  DetailOrderPage({this.orderModel});

  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  List<String> mangIdMon = [];
  List<String> mangSoLuongMon = [];
  List<String> mangIdTypeMon = [];

  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();

    final idMon = widget.orderModel.idMon;
    final soLuongMon = widget.orderModel.soLuongMon;
    final idTypeMon = widget.orderModel.idTypeMon;
    mangIdMon = idMon.split(',');
    mangSoLuongMon = soLuongMon.split(',');
    mangIdTypeMon = idTypeMon.split(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 15.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
                margin: EdgeInsets.only(bottom: 20.h, top: 10.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    color: AppColors.primaryColor),
                child: Text(
                  'Bàn ${widget.orderModel.ban}',
                  style: TextStyle(fontSize: 30.sp, color: Colors.white),
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => FutureBuilder<DocumentSnapshot>(
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return Container(
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: data['image'] != null
                                          ? NetworkImage(data['image'])
                                          : AssetImage(
                                              ImageConstants.cafeSplash),
                                      fit: BoxFit.cover)),
                              width: 90,
                              height: 90,
                              margin: EdgeInsets.only(right: 10.w),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: TextStyle(fontSize: 20.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Số lượng: ${mangSoLuongMon[index]}',
                                      style: TextStyle(fontSize: 20.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${formatter.format(int.parse(data['price']))} đồng',
                                      style: TextStyle(fontSize: 20.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Center(
                      child: Container(
                        child: Lottie.asset('assets/gifs/loading_gif.json',
                            width: 80, height: 80),
                      ),
                    );
                  },
                  future: FirebaseFirestore.instance
                      .collection(mangIdTypeMon[index])
                      .doc(mangIdMon[index])
                      .get(),
                ),
                itemCount: mangIdMon.length,
              ),
              SizedBox(
                height: 50.h,
              ),
              ButtonTheme(
                minWidth: 230.w,
                child: RaisedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => DialogConfirmDoneOrder(
                              orderModel: widget.orderModel,
                            ));

                    RoutesTabBottom.instance.popUntil(TabItem.main);
                  },
                  color: AppColors.primaryColor,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  child: Text('Hoàn thành',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontConstants.montserratBold,
                          fontSize: 23.sp)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
