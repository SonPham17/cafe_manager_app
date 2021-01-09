import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/widgets/custom_expandable_listview_widget.dart';
import 'package:cafe_manager_app/common/widgets/dialog_add_drink.dart';
import 'package:cafe_manager_app/common/widgets/dialog_add_type_drink.dart';
import 'package:cafe_manager_app/common/widgets/dialog_delete_menu.dart';
import 'package:cafe_manager_app/common/widgets/dialog_edit_drink.dart';
import 'package:cafe_manager_app/common/widgets/dialog_question.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  MenuCubit _menuCubit;

  Animation<double> _animation;
  AnimationController _animationController;
  List<String> listType = <String>[];
  List<int> listIdType = <int>[];

  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _menuCubit = Injector.resolve<MenuCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Image.asset(ImageConstants.backgroundAppbar),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(top: 130.h,bottom: 10.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.restaurant_menu),
                      Text(
                        'Menu',
                        style: TextStyle(fontSize: 30.sp),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _menuCubit.streamListTypeMenu(),
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
                          child: Text('Dữ liệu đang trống!'),
                        );
                      }

                      final data = snapshot.data.docs;
                      listType.clear();
                      listIdType.clear();
                      data.forEach((element) {
                        listType.add(element.data()['type']);
                        listIdType.add(element.data()['id']);
                      });
                      return ListView(
                        children: <Widget>[
                          Column(
                            children: data.map((item) {
                              return StreamBuilder<QuerySnapshot>(
                                builder: (_, snapshot) {
                                  if (snapshot.hasError) {
                                    return CustomExpandableListView(
                                      header: _header('${item.data()['type']}'),
                                      items: [
                                        Text(
                                          'Something went wrong',
                                          style: TextStyle(fontSize: 30.sp),
                                        )
                                      ],
                                      headerEdgeInsets:
                                          EdgeInsets.only(left: 16.0, right: 16.0),
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CustomExpandableListView(
                                      header: _header('${item.data()['type']}'),
                                      items: [
                                        Center(
                                          child: Container(
                                            child: Lottie.asset(
                                                'assets/gifs/loading_gif.json',
                                                width: 80,
                                                height: 80),
                                          ),
                                        )
                                      ],
                                      headerEdgeInsets:
                                          EdgeInsets.only(left: 16.0, right: 16.0),
                                    );
                                  }

                                  if (snapshot.data.docs.isEmpty) {
                                    return CustomExpandableListView(
                                      header: _header('${item.data()['type']}'),
                                      items: [
                                        Container(
                                          child: Center(
                                            child: Text('Dữ liệu đang trống!'),
                                          ),
                                          height: 50,
                                        )
                                      ],
                                      headerEdgeInsets:
                                          EdgeInsets.only(left: 16.0, right: 16.0),
                                    );
                                  }

                                  return CustomExpandableListView(
                                    header: _header('${item.data()['type']}'),
                                    items: snapshot.data.docs
                                        .map((document) => Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w,
                                                  right: 10.w,
                                                  top: 5.h,
                                                  bottom: 5.h),
                                              height: 100,
                                              child: Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.25,
                                                secondaryActions: [
                                                  IconSlideAction(
                                                    caption: 'Sửa',
                                                    color: Colors.black45,
                                                    icon: Icons.more_horiz,
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            DialogEditDrink(
                                                          typeMenu: item
                                                              .data()['id']
                                                              .toString(),
                                                          id: document.id,
                                                          urlImage: document
                                                              .data()['image'],
                                                              name: document
                                                                  .data()['name'],
                                                              price: document
                                                                  .data()['price'].toString(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  IconSlideAction(
                                                    caption: 'Xoá',
                                                    color: Colors.red,
                                                    icon: Icons.delete,
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) => DialogDeleteMenu(
                                                            id: document.id,
                                                            typeMenu: item
                                                                .data()['id']
                                                                .toString(),
                                                            i18nLocalizationContent:
                                                                'Bạn có muốn xoá thông tin mặt hàng này không ?',
                                                            i18nLocalizationConfirmText:
                                                                'Đồng ý',
                                                            i18nLocalizationCancelText:
                                                                'Huỷ',
                                                            i18nLocalizationTitle:
                                                                'Xoá món trong menu'),
                                                      );
                                                    },
                                                  ),
                                                ],
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          image: DecorationImage(
                                                              image: document.data()[
                                                                          'image'] !=
                                                                      null
                                                                  ? NetworkImage(
                                                                      document.data()[
                                                                          'image'])
                                                                  : AssetImage(
                                                                      ImageConstants
                                                                          .cafeSplash),
                                                              fit: BoxFit.cover)),
                                                      width: 100,
                                                      height: 100,
                                                      margin: EdgeInsets.only(
                                                          right: 10.w),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.h, bottom: 5.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            document.data()['name'],
                                                            style: TextStyle(
                                                                fontSize: 25.sp),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            '${formatter.format(int.parse(document.data()['price']))} đồng',
                                                            style: TextStyle(
                                                                fontSize: 20.sp),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    headerEdgeInsets:
                                        EdgeInsets.only(left: 16.0, right: 16.0),
                                  );
                                },
                                stream: FirebaseFirestore.instance
                                    .collection('${item.data()['id']}')
                                    .snapshots(),
                              );
                            }).toList(),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Thêm loại vào menu",
              iconColor: Colors.white,
              bubbleColor: AppColors.primaryColor,
              icon: Icons.restaurant_menu,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogAddTypeDrink(
                    menuCubit: _menuCubit,
                  ),
                );
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Thêm món vào menu",
              iconColor: Colors.white,
              bubbleColor: AppColors.primaryColor,
              icon: Icons.emoji_food_beverage_rounded,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                if (listType.length == 0) {
                  Injector.resolve<SnackBarCubit>()
                      .showSnackBar('Trước tiên bạn hãy thêm loại vào menu');
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => DialogAddDrink(
                      menuCubit: _menuCubit,
                      listType: listType,
                      listIdType: listIdType,
                    ),
                  );
                }
                _animationController.reverse();
              },
            ),
          ],
          animation: _animation,
          onPress: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          iconColor: AppColors.primaryColor,
          icon: AnimatedIcons.add_event,
        ));
  }

  Widget _header(String name) => Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
}
