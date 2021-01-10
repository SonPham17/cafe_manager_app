import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/string_constants.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:flutter_translate/global.dart';

final Map<TabItem, String> tabName = {
  TabItem.main: translate(StringConstants.tabMain),
  TabItem.menu: translate(StringConstants.tabMenu),
  TabItem.setting: translate(StringConstants.tabSetting),
};

final Map<TabItem, IconData> tabImage = {
  TabItem.main: Icons.home_filled,
  TabItem.menu: Icons.restaurant_menu,
  TabItem.setting: Icons.person_rounded,
};

class CustomBottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  CustomBottomNavigation({
    this.currentTab,
    this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 15.sp,
      unselectedFontSize: 15.sp,
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.main),
        _buildItem(tabItem: TabItem.menu),
        _buildItem(tabItem: TabItem.setting),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData image = tabImage[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        image,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style:
            TextStyle(color: _colorTabMatching(item: tabItem), fontSize: 20.sp),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? Colors.white : Colors.black38;
  }
}
