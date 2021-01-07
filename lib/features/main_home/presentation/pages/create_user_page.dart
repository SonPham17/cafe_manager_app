import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/constants/string_constants.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/global.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';

class CreateUserPage extends StatefulWidget {
  final String type;

  CreateUserPage({this.type});

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  MainHomeCubit _mainHomeCubit;

  Gender _genderType = Gender.male;
  DateTime selectedDate = DateTime.now();

  TextEditingController _controllerUserLogin;
  TextEditingController _controllerPassword;
  TextEditingController _controllerFirstName;
  TextEditingController _controllerLastName;
  TextEditingController _controllerEmail;
  TextEditingController _controllerDateOfBirth;
  TextEditingController _controllerPhone;
  TextEditingController _controllerAddress;

  @override
  void initState() {
    super.initState();

    _mainHomeCubit = Injector.resolve<MainHomeCubit>();

    _controllerUserLogin = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerFirstName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerDateOfBirth = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerAddress = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Tạo mới tài khoản ${widget.type == 'chef' ? 'đầu bếp' : 'bồi bàn'}'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 200.w,
                margin: EdgeInsets.only(top: 20.h),
                height: 200.h,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstants.avatarDemo),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'User Login',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerUserLogin,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          translate(StringConstants.password),
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerPassword,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person_pin,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'First Name',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerFirstName,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person_pin,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Last Name',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerLastName,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerEmail,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.cake_rounded,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Date Of Birth',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: TextField(
                        enabled: false,
                        controller: _controllerDateOfBirth,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                width: 10,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconConstants.gender,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            children: <Widget>[
                              Radio<Gender>(
                                groupValue: _genderType,
                                value: Gender.male,
                                onChanged: (Gender newValue) {
                                  setState(() {
                                    _genderType = newValue;
                                  });
                                },
                              ),
                              Text('Male'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            children: <Widget>[
                              Radio<Gender>(
                                groupValue: _genderType,
                                value: Gender.female,
                                onChanged: (Gender newValue) {
                                  setState(() {
                                    _genderType = newValue;
                                  });
                                },
                              ),
                              Text('Female'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Phone',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerPhone,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: _controllerAddress,
                      onChanged: (text) {
                        // _loginCubit.userNameSubject.sink
                        //     .add(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              width: 10,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ButtonTheme(
                minWidth: 180.w,
                height: 60.h,
                child: RaisedButton(
                  onPressed: () async {
                    if(widget.type == 'chef'){
                      await _mainHomeCubit.createUserChef(
                        userLogin: _controllerUserLogin.text.trim(),
                        password: _controllerPassword.text,
                        firstName: _controllerFirstName.text.trim(),
                        email: _controllerEmail.text.trim(),
                        lastName: _controllerLastName.text.trim(),
                        dateOfBirth: _controllerDateOfBirth.text.trim(),
                        gender: _genderType,
                        phone: _controllerPhone.text.trim(),
                        address: _controllerAddress.text.trim(),
                      );
                    }else{
                      await _mainHomeCubit.createUserWaiter(
                        userLogin: _controllerUserLogin.text.trim(),
                        password: _controllerPassword.text,
                        firstName: _controllerFirstName.text.trim(),
                        email: _controllerEmail.text.trim(),
                        lastName: _controllerLastName.text.trim(),
                        dateOfBirth: _controllerDateOfBirth.text.trim(),
                        gender: _genderType,
                        phone: _controllerPhone.text.trim(),
                        address: _controllerAddress.text.trim(),
                      );
                    }

                    Navigator.of(context).pop();
                  },
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  child: Text('Tạo',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontConstants.montserratRegular,
                          fontSize: 27.sp)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _controllerDateOfBirth.text = "${picked.toLocal()}".split(' ')[0];
      });
  }
}
