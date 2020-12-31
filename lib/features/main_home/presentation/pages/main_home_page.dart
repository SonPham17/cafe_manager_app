import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/constants/string_constants.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/features/main_home/presentation/widgets/card_home_widget.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageConstants.backgroundAppbar),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CardHome(
                        onTap: (){
                          RoutesTabBottom.instance.navigateTo(TabItem.main, RouteName.tabHomeChef);
                        },
                        label: 'Danh sách đầu bếp',
                        icon: IconConstants.cooking,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: CardHome(
                        onTap: (){
                          RoutesTabBottom.instance.navigateTo(TabItem.main, RouteName.tabHomeWaiter);
                        },
                        label: 'Danh sách bồi bàn',
                        icon: IconConstants.waiter,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CardHome(
                        label: 'Danh sách order',
                        icon: IconConstants.order,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: CardHome(
                        label: 'Danh sách bàn',
                        icon: IconConstants.table,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
