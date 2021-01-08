import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogAddTable extends StatelessWidget {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

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
                'Thêm bàn mới',
                style: const TextStyle(
                    color: Color.fromRGBO(132, 62, 187, 1),
                    fontSize: 20,
                    fontFamily: FontConstants.montserratBold,
                    letterSpacing: -0.78),
              ),
            ),
            Text(
              'Bạn có muốn thêm bàn mới vào quán của mình không?',
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
                      onTap: () async{
                        Injector.resolve<LoadingCubit>().showLoading(true);

                        CollectionReference tables =
                        _firebaseFireStore.collection(FirebaseCollectionConstants.table);

                        final instanceTable = await tables.get();
                        await tables.add({
                          'id' : instanceTable.size,
                          'isEmpty' : true,
                        }).then((value) => Injector.resolve<SnackBarCubit>().showSnackBar('Thêm bàn thành công!'))
                        .catchError((error)=>Injector.resolve<SnackBarCubit>().showSnackBar('Thêm bàn thất bại!'));

                        Injector.resolve<LoadingCubit>().showLoading(false);
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
                                'Thêm',
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
