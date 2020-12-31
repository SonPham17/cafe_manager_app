class ChefModel{
  int age;
  String image;
  String login;
  String name;
  String password;
  String phone;

  ChefModel({
    this.age,
    this.image,
    this.login,
    this.name,
    this.password,
    this.phone,
  });

  ChefModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    image = json['image'];
    login = json['userLogin'];
    name = json['fullName'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() =>
      {
        'age': age,
        'image': image,
        'login': login,
        'name': name,
        'password': password,
        'phone': phone,
      };

  @override
  String toString() {
    return 'UserLoginModel{age: $age, image: $image, login: $login, name: $name, password: $password, phone: $phone}';
  }
}