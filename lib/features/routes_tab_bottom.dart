import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/navigation/fade_in_route.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/chef_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/create_user_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/edit_profile_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/main_home_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/waiter_page.dart';
import 'package:cafe_manager_app/features/menu/presentation/pages/menu_page.dart';
import 'package:cafe_manager_app/features/setting/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';

class RoutesTabBottom {
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };

  RoutesTabBottom._internal();

  static final RoutesTabBottom _instance = RoutesTabBottom._internal();

  static RoutesTabBottom get instance => _instance;

  factory RoutesTabBottom() => _instance;

  Future<dynamic> navigateTo(TabItem tabItem, String routeName,
          {dynamic arguments}) =>
      navigatorKeys[tabItem]
          .currentState
          .pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(TabItem tabItem, String routeName,
          {dynamic arguments}) =>
      navigatorKeys[tabItem].currentState.pushNamedAndRemoveUntil(
            routeName,
            (Route<dynamic> route) => false,
            arguments: arguments,
          );

  Future<dynamic> navigateAndReplace(TabItem tabItem, String routeName,
          {dynamic arguments}) =>
      navigatorKeys[tabItem]
          .currentState
          .pushReplacementNamed(routeName, arguments: arguments);

  dynamic pop(TabItem tabItem, {dynamic result}) =>
      navigatorKeys[tabItem].currentState.pop(result);

  static Route<dynamic> generateRouteMain(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.tabRoot:
        return FadeInRoute(widget: MainHomePage());
        break;
      case RouteName.tabHomeChef:
        return FadeInRoute(widget: ChefPage());
        break;
      case RouteName.tabHomeWaiter:
        return FadeInRoute(widget: WaiterPage());
        break;
      case RouteName.createChef:
        final type = settings.arguments as String;
        return FadeInRoute(widget: CreateUserPage(type: type,));
        break;
      case RouteName.tabEditProfile:
        final params = settings.arguments as Map<String, dynamic>;
        return FadeInRoute(
            widget: EditProfilePage(
          password: params['password'],
          firstName: params['firstName'],
          gender: params['gender'],
          lastName: params['lastName'],
          email: params['email'],
          dateOfBirth: params['dateOfBirth'],
          phone: params['phone'],
          address: params['address'],
          id: params['id'],
          editType: params['type'],
        ));
        break;
      default:
        return _emptyRoute(settings);
    }
  }

  static Route<dynamic> generateRouteMenu(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.tabRoot:
        return FadeInRoute(widget: MenuPage());
      default:
        return _emptyRoute(settings);
    }
  }

  static Route<dynamic> generateRouteSetting(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.tabRoot:
        return FadeInRoute(widget: SettingPage());
      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
