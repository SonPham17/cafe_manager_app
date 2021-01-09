import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/features/main_home/data/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogConfirmDoneOrder extends StatelessWidget {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final OrderModel orderModel;

  DialogConfirmDoneOrder({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 25.0,
          children: [
            Center(
              child: Text(
                'Xác nhận hoàn thành đơn',
                style: const TextStyle(
                    color: Color.fromRGBO(132, 62, 187, 1),
                    fontSize: 20,
                    fontFamily: FontConstants.montserratBold,
                    letterSpacing: -0.78),
              ),
            ),
            Text(
              'Đơn này đã làm xong ? Bạn muốn hoàn thành không ?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  color: Color.fromRGBO(95, 95, 95, 1),
                  fontSize: 14,
                  fontFamily: FontConstants.montserratRegular),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Injector.resolve<LoadingCubit>().showLoading(true);

                        CollectionReference order = _firebaseFireStore
                            .collection(FirebaseCollectionConstants.order);

                        await order
                            .doc(orderModel.id)
                            .delete()
                            .then((value) async {
                          CollectionReference tables = _firebaseFireStore
                              .collection(FirebaseCollectionConstants.table);

                          await tables
                              .doc('${orderModel.idBan}')
                              .update({'isEmpty': true}).then((value) {
                            Injector.resolve<SnackBarCubit>()
                                .showSnackBar('Hoàn thành đơn thành công');
                          }).catchError((error) {
                            Injector.resolve<SnackBarCubit>()
                                .showSnackBar('Hoàn thành đơn thất bại');
                          });
                        }).catchError((error) {
                          Injector.resolve<SnackBarCubit>()
                              .showSnackBar('Hoàn thành đơn thất bại');
                        });

                        Navigator.of(context).pop();
                        Injector.resolve<LoadingCubit>().showLoading(false);
                      },
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(132, 62, 187, 1)),
                            child: Center(
                              child: Text(
                                'Hoàn thành',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily:
                                        FontConstants.montserratRegular),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(132, 62, 187, 1)),
                            child: Center(
                              child: Text(
                                'Huỷ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily:
                                        FontConstants.montserratRegular),
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
