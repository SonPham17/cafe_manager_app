import 'package:cafe_manager_app/common/navigation/fade_in_route.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/pages/login_page.dart';
import 'package:cafe_manager_app/features/authentication/splash/presentation/pages/splash_page.dart';
import 'package:cafe_manager_app/features/home/presentation/pages/home_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/confirm_order_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/create_user_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/detail_order_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/order_table_page.dart';
import 'package:cafe_manager_app/features/main_home/presentation/pages/pay_page.dart';
import 'package:flutter/material.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    return navigatorKey.currentState.pop(result);
  }

  dynamic popUntil({dynamic result}) =>
      navigatorKey.currentState.popUntil((route) => route.isFirst);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return FadeInRoute(widget: SplashPage());
        break;
      case RouteName.login:
        return FadeInRoute(widget: LoginPage());
        break;
      case RouteName.home:
        return FadeInRoute(widget: HomePage());
        break;
      case RouteName.tabPay:
        return FadeInRoute(widget: PayPage(
          idBan: settings.arguments as String,
        ));
        break;
      case RouteName.tabConfirmOrder:
        final param = settings.arguments as Map<String, dynamic>;
        return FadeInRoute(
            widget: ConfirmOrderPage(
              dataMenuDrink: param['listOrder'],
              ban: '${int.parse(param['ban']) + 1}',
              idBan: param['idBan'],
            ));
        break;
      case RouteName.tabDetailOrder:
        return FadeInRoute(
            widget: DetailOrderPage(
              orderModel: settings.arguments,
            ));
        break;
      case RouteName.tabOrderTable:
        final param = settings.arguments as Map<String, dynamic>;
        return FadeInRoute(
            widget: OrderTablePage(
              id: param['id'].toString(),
              idBan: param['idBan'],
            ));
        break;
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
