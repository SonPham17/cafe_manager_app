import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/manager/user_manager.dart';
import 'package:cafe_manager_app/common/navigation/route_name.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/pages/login_page.dart';
import 'package:cafe_manager_app/features/routes.dart';
import 'package:cafe_manager_app/features/routes_tab_bottom.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final userLogin = UserManager.instance.userLoginModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageConstants.backgroundAppbar),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 110.h,
                ),
                Center(
                  child: ClipOval(
                    child: UserManager.instance.userLoginModel.image == null
                        ? Image.asset(
                            ImageConstants.avatarDemo,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            UserManager.instance.userLoginModel.image,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  child: Text(
                    'Họ và tên: ${userLogin.firstName} ${userLogin.lastName}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    'Ngày sinh: ${userLogin.dateOfBirth}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    'Email: ${userLogin.email}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    'Giới tính: ${userLogin.gender}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    'SĐT: ${userLogin.phone}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    'Địa chỉ: ${userLogin.address}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: ButtonTheme(
                    minWidth: 230.w,
                    child: RaisedButton(
                      onPressed: () async {
                        await UserManager.instance.logOut();
                        Routes.instance.navigateAndRemove(RouteName.login);
                      },
                      color: AppColors.primaryColor,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50)),
                      child: Text('Đăng xuất',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontConstants.montserratBold,
                              fontSize: 23.sp)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
