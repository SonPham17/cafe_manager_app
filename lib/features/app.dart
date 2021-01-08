import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/loading/loading_state.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_state.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/utils/screen_utils.dart';
import 'package:cafe_manager_app/features/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/localized_app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';

class App extends StatelessWidget {
  List<BlocProvider> _getProviders() => [
        BlocProvider<LoadingCubit>(
            create: (_) => Injector.resolve<LoadingCubit>()),
        BlocProvider<SnackBarCubit>(
          create: (_) => Injector.resolve<SnackBarCubit>(),
        )
      ];

  List<BlocListener> _getBlocListener(context) => [
        BlocListener<SnackBarCubit, SnackBarState>(
            listener: _mapListenerSnackBarState),
        BlocListener<LoadingCubit, LoadingState>(
            listener: _mapListenerLoadingState),
      ];

  void _mapListenerSnackBarState(BuildContext context, SnackBarState state) {
    if (state is ShowSnackBarState) {
      Fluttertoast.showToast(
          msg: state.msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0.sp);
    }
  }

  void _mapListenerLoadingState(BuildContext context, LoadingState state) {
    if (state is ShowLoadingState) {
      if(state.isShow){
        EasyLoading.show(status: 'Loading ...');
      }else{
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        navigatorKey: Routes.instance.navigatorKey,
        title: 'Cafe Manager',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: RouteName.splash,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Montserrat Bold',
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        builder: EasyLoading.init(
          builder: (context, widget) {
            ScreenUtil.init(context);
            return Container(
              child: MultiBlocListener(
                listeners: _getBlocListener(context),
                child: widget,
              ),
            );
          },
        ),
      ),
    );
  }
}
