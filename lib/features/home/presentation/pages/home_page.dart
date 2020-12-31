import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/widgets/custom_bottom_navigation.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.main;

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      RoutesTabBottom.instance.navigatorKeys[tabItem].currentState
          .popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final isFirstRouteInCurrentTab = !await RoutesTabBottom
            .instance.navigatorKeys[_currentTab].currentState
            .maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.main) {
            // select 'main' tab
            _selectTab(TabItem.main);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Offstage(
              offstage: _currentTab != TabItem.main,
              child: Navigator(
                key: RoutesTabBottom.instance.navigatorKeys[TabItem.main],
                initialRoute: RouteName.tabRoot,
                onGenerateRoute: RoutesTabBottom.generateRouteMain,
              ),
            ),
            Offstage(
              offstage: _currentTab != TabItem.menu,
              child: Navigator(
                key: RoutesTabBottom.instance.navigatorKeys[TabItem.menu],
                initialRoute: RouteName.tabRoot,
                onGenerateRoute: RoutesTabBottom.generateRouteMenu,
              ),
            ),
            Offstage(
              offstage: _currentTab != TabItem.setting,
              child: Navigator(
                key: RoutesTabBottom.instance.navigatorKeys[TabItem.setting],
                initialRoute: RouteName.tabRoot,
                onGenerateRoute: RoutesTabBottom.generateRouteSetting,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }
}
