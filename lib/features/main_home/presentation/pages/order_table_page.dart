import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/my_iterable_extensions.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/widgets/custom_expandable_listview_widget.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_state.dart';
import 'package:cafe_manager_app/features/menu/data/models/menu_type_model.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';

class OrderTablePage extends StatefulWidget {
  final String id;
  final String idBan;

  OrderTablePage({this.id,this.idBan});

  @override
  _OrderTablePageState createState() => _OrderTablePageState();
}

class _OrderTablePageState extends State<OrderTablePage> {
  final formatter = new NumberFormat("#,###");
  List<MenuTypeModel> dataMenuType = [];
  final List<MenuDrink> dataMenuDrink = [];
  MainHomeCubit _mainHomeCubit;

  @override
  void initState() {
    super.initState();

    _mainHomeCubit = Injector.resolve<MainHomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lên đơn order bàn số ${1 + int.parse(widget.id)}'),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.all(10),
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
                  StreamBuilder<QuerySnapshot>(
                    stream: Injector.resolve<MenuCubit>().streamListTypeMenu(),
                    builder: (_, snapshot1) {
                      if (snapshot1.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(fontSize: 30.sp),
                          ),
                        );
                      }

                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            child: Lottie.asset('assets/gifs/loading_gif.json',
                                width: 80, height: 80),
                          ),
                        );
                      }

                      if (snapshot1.data.docs.isEmpty) {
                        return Center(
                          child: Text('Menu đang trống!'),
                        );
                      }

                      var data = snapshot1.data.docs;
                      data = data.sortedBy((e) => e.data()['id']);

                      dataMenuType = data
                          .map((element) =>
                              MenuTypeModel.fromJson(element.data()))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataMenuType.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return StreamBuilder<QuerySnapshot>(
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return CustomExpandableListView(
                                  header: _header('${dataMenuType[index].id}'),
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
                                  header: _header('${dataMenuType[index].id}'),
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
                                  header:
                                      _header('${dataMenuType[index].type}'),
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

                              final data = snapshot.data.docs;
                              final dataDrink = data
                                  .map((e) => MenuDrink.fromJson(e.data(),e.id))
                                  .toList();

                              data.forEach((element) {
                                dataMenuDrink
                                    .add(MenuDrink.fromJson(element.data(),element.id));
                              });

                              return CustomExpandableListView(
                                header: _header('${dataMenuType[index].type}'),
                                items: dataDrink
                                    .map((document) => Container(
                                          margin: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 5.h,
                                              bottom: 5.h),
                                          height: 100,
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
                                                        image: document.image !=
                                                                null
                                                            ? NetworkImage(
                                                                document.image)
                                                            : AssetImage(
                                                                ImageConstants
                                                                    .cafeSplash),
                                                        fit: BoxFit.cover)),
                                                width: 100,
                                                height: 100,
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 5.h, bottom: 5.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        document.name,
                                                        style: TextStyle(
                                                            fontSize: 25.sp),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            '${formatter.format(int.parse(document.price))} đồng',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.sp),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove_circle_outlined,
                                                                    size: 35,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    if (document
                                                                            .order >
                                                                        0) {
                                                                      document
                                                                          .order--;
                                                                      final index = dataMenuDrink.indexWhere((element) =>
                                                                          document
                                                                              .name ==
                                                                          element
                                                                              .name);
                                                                      dataMenuDrink[index]
                                                                              .order =
                                                                          document
                                                                              .order;
                                                                      _mainHomeCubit
                                                                          .giamOrder(
                                                                              dataMenuDrink);
                                                                    }
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                BlocBuilder<
                                                                        MainHomeCubit,
                                                                        MainHomeState>(
                                                                    cubit:
                                                                        _mainHomeCubit,
                                                                    builder: (_,
                                                                        state) {
                                                                      return Text(
                                                                          '${document.order}');
                                                                    }),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    document
                                                                        .order++;
                                                                    final index = dataMenuDrink.indexWhere((element) =>
                                                                        document
                                                                            .name ==
                                                                        element
                                                                            .name);
                                                                    dataMenuDrink[index]
                                                                            .order =
                                                                        document
                                                                            .order;
                                                                    _mainHomeCubit
                                                                        .tangOrder(
                                                                            dataMenuDrink);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .add_circle,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                headerEdgeInsets:
                                    EdgeInsets.only(left: 16.0, right: 16.0),
                              );
                            },
                            stream: FirebaseFirestore.instance
                                .collection('${dataMenuType[index].id}')
                                .snapshots(),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
            BlocBuilder<MainHomeCubit, MainHomeState>(
              cubit: _mainHomeCubit,
              builder: (_, state) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity:
                      (state.soMon == null || state.soMon == 0) ? 0.0 : 1.0,
                  child: GestureDetector(
                    onTap: () {
                      final listOrder = dataMenuDrink
                          .where((element) => element.order > 0)
                          .toList();

                      RoutesTabBottom.instance.navigateTo(
                          TabItem.main, RouteName.tabConfirmOrder,
                          arguments: {
                            'listOrder' : listOrder,
                            'ban' : widget.id,
                            'idBan': widget.idBan,
                          });
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 30.h),
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primaryColor),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${state.soMon ?? 0} món',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp),
                                  ),
                                  Text(
                                    state.monOrder ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              '${formatter.format(state.soTien ?? 0)}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _header(String name) => Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
}
