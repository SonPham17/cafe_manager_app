import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/features/menu/data/models/menu_type_model.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:intl/intl.dart';

class ConfirmOrderPage extends StatefulWidget {
  final List<MenuDrink> dataMenuDrink;
  final String ban;
  final String idBan;

  ConfirmOrderPage({this.dataMenuDrink, this.ban, this.idBan});

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final formatter = new NumberFormat("#,###");
  String tongTien = '';
  int tong = 0;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.dataMenuDrink.length; i++) {
      if (i != 0) {
        tongTien += ' + ';
      }
      tongTien +=
          '${formatter.format(int.parse(widget.dataMenuDrink[i].price))}x${widget.dataMenuDrink[i].order}';
      tong += int.parse(widget.dataMenuDrink[i].price) *
          widget.dataMenuDrink[i].order;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận đơn'),
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h, bottom: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    color: AppColors.primaryColor),
                child: Text(
                  'Bàn ${widget.ban}',
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
                itemBuilder: (_, index) => Container(
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: widget.dataMenuDrink[index].image != null
                                    ? NetworkImage(
                                        widget.dataMenuDrink[index].image)
                                    : AssetImage(ImageConstants.cafeSplash),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.dataMenuDrink[index].name,
                                style: TextStyle(fontSize: 20.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Số lượng: ${widget.dataMenuDrink[index].order}',
                                style: TextStyle(fontSize: 20.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${formatter.format(int.parse(widget.dataMenuDrink[index].price))} đồng',
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
                ),
                itemCount: widget.dataMenuDrink.length,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Tổng tiền= $tongTien = ${formatter.format(tong)} vnđ',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.h,
              ),
              ButtonTheme(
                minWidth: 230.w,
                child: RaisedButton(
                  onPressed: () async {
                    Injector.resolve<LoadingCubit>().showLoading(true);

                    CollectionReference orders = _firebaseFireStore
                        .collection(FirebaseCollectionConstants.order);

                    var idMon = '';
                    var soLuongMon = '';
                    var idTypeMon = '';

                    for (int i = 0; i < widget.dataMenuDrink.length; i++) {
                      idMon += '${widget.dataMenuDrink[i].id}';
                      soLuongMon += '${widget.dataMenuDrink[i].order}';
                      idTypeMon += '${widget.dataMenuDrink[i].idType}';
                      if (i != widget.dataMenuDrink.length - 1) {
                        idMon += ',';
                        soLuongMon += ',';
                        idTypeMon += ',';
                      }
                    }

                    await orders.add({
                      'tongTien': tong,
                      'ban': widget.ban,
                      'idBan' : widget.idBan,
                      'idMon': idMon,
                      'soLuongMon': soLuongMon,
                      'idTypeMon' : idTypeMon,
                    }).then((value) async {
                      CollectionReference tables = _firebaseFireStore
                          .collection(FirebaseCollectionConstants.table);

                      await tables
                          .doc(widget.idBan)
                          .update({'isEmpty': false})
                          .then((value) => Injector.resolve<SnackBarCubit>()
                              .showSnackBar('Order thành công!'))
                          .catchError((error) =>
                              Injector.resolve<SnackBarCubit>()
                                  .showSnackBar('Order thất bại!'));
                    }).catchError((error) => Injector.resolve<SnackBarCubit>()
                        .showSnackBar('Order thất bại!'));

                    Injector.resolve<LoadingCubit>().showLoading(false);
                    RoutesTabBottom.instance.popUntil(TabItem.main);
                  },
                  color: AppColors.primaryColor,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  child: Text('ORDER NOW',
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
