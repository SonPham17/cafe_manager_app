import 'dart:io';

import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class DialogEditDrink extends StatefulWidget {
  final String typeMenu;
  final String id;
  final String urlImage;
  final String name;
  final String price;

  DialogEditDrink(
      {this.typeMenu, this.id, this.urlImage, this.name, this.price});

  @override
  _DialogEditDrinkState createState() => _DialogEditDrinkState();
}

class _DialogEditDrinkState extends State<DialogEditDrink> {
  final TextEditingController textEditingDrinkController =
      TextEditingController();
  final TextEditingController textEditingPriceController =
      TextEditingController();
  File _image;
  final picker = ImagePicker();

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    textEditingPriceController.text = widget.price;
    textEditingDrinkController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 15.h, bottom: 20.h),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20.0,
              children: [
                Text('Cập nhật thông tin món',
                    style: const TextStyle(
                        color: Color.fromRGBO(132, 62, 187, 1),
                        fontSize: 20,
                        fontFamily: FontConstants.montserratBold,
                        letterSpacing: -0.78)),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: ClipOval(
                      child: _image == null
                          ? (widget.urlImage == null
                              ? Image.asset(
                                  ImageConstants.cafeSplash,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.urlImage,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ))
                          : Image.file(_image,
                              height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  child: TextField(
                    controller: textEditingDrinkController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tên món. VD: Bạc xỉu, nâu đá',
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  child: TextField(
                    controller: textEditingPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Giá tiền. VD: 30000',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Injector.resolve<LoadingCubit>().showLoading(true);

                          if (textEditingDrinkController.text.isNotEmpty &&
                              textEditingPriceController.text.isNotEmpty) {
                            var linkPath;

                            if (_image != null) {
                              String fileName = basename(_image.path);
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('uploads/$fileName');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(_image);
                              TaskSnapshot taskSnapshot = await uploadTask;

                              linkPath =
                                  await taskSnapshot.ref.getDownloadURL();
                            }

                            CollectionReference drink =
                                _firebaseFireStore.collection(widget.typeMenu);

                            if (linkPath != null) {
                              await drink.doc(widget.id).update({
                                'name': textEditingDrinkController.text.trim(),
                                'price': textEditingPriceController.text.trim(),
                                'image': linkPath,
                              }).then((value) {
                                Injector.resolve<SnackBarCubit>().showSnackBar(
                                    'Cập nhật thông tin thành công!');
                              }).catchError((error) {
                                Injector.resolve<SnackBarCubit>().showSnackBar(
                                    'Cập nhật thông tin thất bại!');
                              });
                            } else {
                              await drink.doc(widget.id).update({
                                'name': textEditingDrinkController.text.trim(),
                                'price': textEditingPriceController.text.trim(),
                              }).then((value) {
                                Injector.resolve<SnackBarCubit>().showSnackBar(
                                    'Cập nhật thông tin thành công!');
                              }).catchError((error) {
                                Injector.resolve<SnackBarCubit>().showSnackBar(
                                    'Cập nhật thông tin thất bại!');
                              });
                            }

                            Navigator.of(context).pop();
                          } else {
                            Injector.resolve<SnackBarCubit>().showSnackBar(
                                'Các trường không được để trống!');
                          }
                          Injector.resolve<LoadingCubit>().showLoading(false);
                        },
                        child: Center(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromRGBO(132, 62, 187, 1)),
                              child: Center(
                                child: Text(
                                  'Cập nhật',
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
                    SizedBox(
                      width: 20.h,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
              ],
            )),
      ),
    );
  }
}
