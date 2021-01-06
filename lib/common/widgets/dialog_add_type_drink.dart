import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';

class DialogAddTypeDrink extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final MenuCubit menuCubit;

  DialogAddTypeDrink({this.menuCubit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h,bottom: 20.h),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 40.0,
          children: [
            Text('Thêm loại vào menu',
                style: const TextStyle(
                    color: Color.fromRGBO(132, 62, 187, 1),
                    fontSize: 20,
                    fontFamily: FontConstants.montserratBold,
                    letterSpacing: -0.78)),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder<String>(
              stream: menuCubit.addTypeMenuSubject.stream,
              builder: (_, snapshot) {
                return TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tên loại. VD: Cà phê, Nước ép, Sinh tố',
                    errorText: snapshot.data,
                  ),
                );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (textEditingController.text.isEmpty) {
                        menuCubit.addTypeMenuSubject.sink
                            .add('Không được để trống');
                      } else {
                        await menuCubit
                            .addTypeMenu(textEditingController.text.trim());
                        Navigator.of(context).pop();
                        menuCubit.addTypeMenuSubject.sink.add(null);
                      }
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
                                  fontFamily: FontConstants.montserratRegular),
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
                      menuCubit.addTypeMenuSubject.sink.add(null);
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
                                  fontFamily: FontConstants.montserratRegular),
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}
