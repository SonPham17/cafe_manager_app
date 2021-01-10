import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/constants/string_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/common/utils/screen_utils.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/bloc/login_cubit.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/widgets/label_radio.dart';
import 'package:cafe_manager_app/features/routes.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textUserNameController;
  TextEditingController _textPasswordController;

  LoginCubit _loginCubit;
  LoginType _loginType = LoginType.manager;

  @override
  void initState() {
    super.initState();

    _textUserNameController = TextEditingController();
    _textPasswordController = TextEditingController();

    _loginCubit = Injector.resolve<LoginCubit>();
    _loginCubit.validateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: ScreenUtil.screenHeightDp * 2 / 3,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil.screenWidthDp,
                  height: ScreenUtil.screenHeightDp,
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
                      Container(
                        margin:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                        width: ScreenUtil.screenWidthDp,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  translate(StringConstants.login),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.sp,
                                      fontFamily:
                                          FontConstants.montserratSemiBold),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 20.w, left: 10.w),
                                  child: TextField(
                                    controller: _textUserNameController,
                                    onChanged: (text) {
                                      _loginCubit.userNameSubject.sink
                                          .add(text);
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: '',
                                        labelText: translate(
                                            StringConstants.userName)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 20.w, left: 10.w, bottom: 10.h),
                                  child: TextField(
                                    onChanged: (text) {
                                      _loginCubit.passSubject.sink.add(text);
                                    },
                                    controller: _textPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        hintText: '',
                                        labelText: translate(
                                            StringConstants.password)),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    LabelRadio(
                                      label: 'Quản lý',
                                      padding: EdgeInsets.all(0),
                                      groupValue: _loginType,
                                      value: LoginType.manager,
                                      onChanged: (LoginType newValue) {
                                        setState(() {
                                          _loginType = newValue;
                                        });
                                      },
                                    ),
                                    LabelRadio(
                                      label: 'Phục vụ',
                                      padding: EdgeInsets.all(0),
                                      groupValue: _loginType,
                                      value: LoginType.waiter,
                                      onChanged: (LoginType newValue) {
                                        setState(() {
                                          _loginType = newValue;
                                        });
                                      },
                                    ),
                                    LabelRadio(
                                      label: 'Đầu bếp',
                                      padding: EdgeInsets.all(0),
                                      groupValue: _loginType,
                                      value: LoginType.chef,
                                      onChanged: (LoginType newValue) {
                                        setState(() {
                                          _loginType = newValue;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                BlocConsumer<LoginCubit, LoginState>(
                                  cubit: _loginCubit,
                                  listener: (_, state) {
                                    context
                                        .read<LoadingCubit>()
                                        .showLoading(false);
                                    if (state is LoginSuccessState) {
                                      Routes.instance.navigateAndRemove(RouteName.home);
                                    }
                                  },
                                  builder: (_, state) {
                                    return ButtonTheme(
                                      minWidth: 180.w,
                                      child: RaisedButton(
                                        onPressed: state.isSuccess
                                            ? () {
                                                context
                                                    .read<LoadingCubit>()
                                                    .showLoading(true);
                                                _loginCubit.login(
                                                    loginType: _loginType,
                                                    userName:
                                                        _textUserNameController
                                                            .text.trim(),
                                                    password:
                                                        _textPasswordController
                                                            .text);
                                              }
                                            : null,
                                        color: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(50)),
                                        child: Text(
                                            translate(StringConstants.login),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: FontConstants
                                                    .montserratRegular,
                                                fontSize: 23.sp)),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();

    _loginCubit.close();
  }
}
