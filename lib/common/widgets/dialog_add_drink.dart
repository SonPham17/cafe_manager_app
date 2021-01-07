import 'dart:io';

import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:image_picker/image_picker.dart';

class DialogAddDrink extends StatefulWidget {
  final MenuCubit menuCubit;
  final List<String> listType;

  DialogAddDrink({this.menuCubit, this.listType});

  @override
  _DialogAddDrinkState createState() => _DialogAddDrinkState();
}

class _DialogAddDrinkState extends State<DialogAddDrink> {
  final TextEditingController textEditingDrinkController =
      TextEditingController();
  final TextEditingController textEditingPriceController =
      TextEditingController();
  File _image;
  final picker = ImagePicker();
  String dropdownValue;

  @override
  void initState() {
    super.initState();

    dropdownValue = widget.listType[0];
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
                Text('Thêm món vào menu',
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
                          ? Image.asset(
                              ImageConstants.cooking,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                StreamBuilder<String>(
                  stream: widget.menuCubit.addDrinkMenuSubject.stream,
                  builder: (_, snapshot) {
                    return Container(
                      height: 55,
                      child: TextField(
                        onChanged: (value) {
                          widget.menuCubit.addDrinkMenuSubject.sink.add(null);
                        },
                        controller: textEditingDrinkController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tên món. VD: Bạc xỉu, nâu đá',
                          errorText: snapshot.data,
                        ),
                      ),
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: widget.menuCubit.addPriceMenuSubject.stream,
                  builder: (_, snapshot) {
                    return Container(
                      height: 55,
                      child: TextField(
                        controller: textEditingPriceController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          widget.menuCubit.addPriceMenuSubject.sink.add(null);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Giá tiền. VD: 30000',
                          errorText: snapshot.data,
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Text('Loại: '),
                    SizedBox(
                      width: 30.w,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_circle_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 1,
                        color: Colors.deepPurple,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: widget.listType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (textEditingPriceController.text.isEmpty) {
                            widget.menuCubit.addPriceMenuSubject.sink
                                .add('Không được để trống');
                          }
                          if (textEditingDrinkController.text.isEmpty) {
                            widget.menuCubit.addDrinkMenuSubject.sink
                                .add('Không được để trống');
                          }
                          if (textEditingDrinkController.text.isNotEmpty &&
                              textEditingPriceController.text.isNotEmpty) {
                            print('zxcxzc');
                          }
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
                    SizedBox(
                      width: 20.h,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.menuCubit.addTypeMenuSubject.sink.add(null);
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
