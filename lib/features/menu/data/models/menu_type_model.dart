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
  String id;
  int idType;
  String image;
  String name;
  String price;
  int order=0;

  MenuDrink({this.idType, this.image, this.name, this.price,this.order,this.id});

  MenuDrink.fromJson(Map<String,dynamic> json,String id){
    idType = json['idType'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    this.id= id;
  }
}