class OrderModel{
  String ban;
  int tongTien;
  String idMon;
  String soLuongMon;
  String idTypeMon;
  String idBan;
  String id;
  String tenMon;

  OrderModel(
      {this.idMon, this.ban, this.tongTien, this.soLuongMon, this.idTypeMon,this.tenMon});

  OrderModel.fromJson(Map<String, dynamic> json, String id) {
    ban = json['ban'];
    tongTien = json['tongTien'];
    idMon = json['idMon'];
    soLuongMon = json['soLuongMon'];
    idTypeMon = json['idTypeMon'];
    idBan = json['idBan'];
    tenMon = json['tenMon'];
    this.id = id;
  }
}