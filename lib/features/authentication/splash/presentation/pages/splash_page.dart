import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/utils/screen_utils.dart';
import 'package:cafe_manager_app/features/authentication/splash/presentation/bloc/splash_cubit.dart';
import 'package:cafe_manager_app/features/authentication/splash/presentation/bloc/splash_state.dart';
import 'package:cafe_manager_app/features/routes.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();

    _splashCubit = Injector.resolve<SplashCubit>();
    Future.delayed(Duration(seconds: 2), () {
      _splashCubit.checkUserIsLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        cubit: _splashCubit,
        listener: (_, state) {
          if (state is UserLoggedState) {
            Routes.instance.navigateAndRemove(RouteName.home);
            print(state.userLoginModel.loginType);
          } else if (state is UserNotLoginState) {
            Routes.instance.navigateAndRemove(RouteName.login);
          }
        },
        child: Container(
            width: ScreenUtil.screenWidthDp,
            height: ScreenUtil.screenHeightDp,
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cafe Manager',
                  style: TextStyle(color: Colors.white, fontSize: 30.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  ImageConstants.cafeSplash,
                  width: 150.w,
                  height: 150.h,
                ),
              ],
            )),
      ),
    );
  }
}
