import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/widgets/dialog_add_drink.dart';
import 'package:cafe_manager_app/common/widgets/dialog_add_type_drink.dart';
import 'package:cafe_manager_app/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
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
            StreamBuilder<QuerySnapshot>(
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
                data.forEach((element) {
                  listType.add(element.data()['type']);
                });
                final listString = ['zxc', '111', 'asdasd'];
                return ListView(
                  children: <Widget>[
                    Column(
                      children: data.map((item) {
                        return ExpandableGroup(
                          header: _header('${item.data()['type']}'),
                          items: _buildItems(context, listString),
                          headerEdgeInsets:
                              EdgeInsets.only(left: 16.0, right: 16.0),
                        );
                      }).toList(),
                    )
                  ],
                );
              },
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

  List<ListTile> _buildItems(BuildContext context, List<String> items) => items
      .map((e) => ListTile(
            title: Text(e),
          ))
      .toList();
}
