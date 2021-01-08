class OrderModel{
  String ban;
  int tongTien;
  String idMon;
  String soLuongMon;
  String idTypeMon;

  OrderModel({this.idMon,this.ban,this.tongTien,this.soLuongMon,this.idTypeMon});

  OrderModel.fromJson(Map<String,dynamic> json){
    ban = json['ban'];
    tongTien = json['tongTien'];
    idMon = json['idMon'];
    soLuongMon = json['soLuongMon'];
    idTypeMon = json['idTypeMon'];
  }
}