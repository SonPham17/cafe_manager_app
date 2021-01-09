import 'package:cafe_manager_app/common/constants/enum_constants.dart';

class UserLoginModel {
  String image;
  String address;
  String dateOfBirth;
  String email;
  String firstName;
  String gender;
  String lastName;
  String password;
  String phone;
  String userLogin;
  LoginType loginType;

  UserLoginModel(
      {this.image,
      this.address,
      this.dateOfBirth,
      this.email,
      this.firstName,
      this.gender,
      this.lastName,
      this.password,
      this.phone,
      this.userLogin,
      this.loginType});

  UserLoginModel.fromJson(Map<String, dynamic> json, LoginType loginType) {
    image = json['image'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    password = json['password'];
    phone = json['phone'];
    userLogin = json['userLogin'];
    this.loginType = loginType;
  }

  Map<String, dynamic> toMap() =>
      {
        'image': image,
        'address': address,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'firstName': firstName,
        'gender': gender,
        'lastName': lastName,
        'password': password,
        'phone': phone,
        'userLogin': userLogin,
        'loginType': loginType.toString(),
      };

  @override
  String toString() {
    return 'UserLoginModel{image: $image, address: $address, dateOfBirth: $dateOfBirth, email: $email, firstName: $firstName, gender: $gender, lastName: $lastName, password: $password, phone: $phone, userLogin: $userLogin, loginType: $loginType}';
  }
}
