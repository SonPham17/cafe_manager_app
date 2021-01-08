class MenuTypeModel {
  int id;
  String type;

  MenuTypeModel({this.id, this.type,});

  MenuTypeModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    type = json['type'];
  }
}

class MenuDrink{
  int idType;
  String image;
  String name;
  int price;

  MenuDrink({this.idType, this.image, this.name, this.price});

  MenuDrink.fromJson(Map<String,dynamic> json){
    idType = json['idType'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
  }
}