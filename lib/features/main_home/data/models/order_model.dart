class OrderModel{
  String ban;
  int tongTien;
  String idMon;
  String soLuongMon;
  String idTypeMon;
  String idBan;
  String id;

  OrderModel(
      {this.idMon, this.ban, this.tongTien, this.soLuongMon, this.idTypeMon});

  OrderModel.fromJson(Map<String, dynamic> json, String id) {
    ban = json['ban'];
    tongTien = json['tongTien'];
    idMon = json['idMon'];
    soLuongMon = json['soLuongMon'];
    idTypeMon = json['idTypeMon'];
    idBan = json['idBan'];
    this.id = id;
  }
}