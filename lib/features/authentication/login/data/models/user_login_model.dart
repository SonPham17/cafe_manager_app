import 'package:cafe_manager_app/common/constants/enum_constants.dart';

class UserLoginModel {
  int age;
  String image;
  String login;
  String name;
  String password;
  String phone;
  LoginType loginType;

  UserLoginModel({
    this.age,
    this.image,
    this.login,
    this.name,
    this.password,
    this.phone,
    this.loginType,
  });

  UserLoginModel.fromJson(Map<String, dynamic> json, LoginType loginType) {
    age = json['age'];
    image = json['image'];
    login = json['login'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    this.loginType = loginType;
  }

  Map<String, dynamic> toMap() =>
      {
        'age': age,
        'image': image,
        'login': login,
        'name': name,
        'password': password,
        'phone': phone,
        'loginType': loginType.toString(),
      };

  @override
  String toString() {
    return 'UserLoginModel{age: $age, image: $image, login: $login, name: $name, password: $password, phone: $phone, loginType: $loginType}';
  }
}
