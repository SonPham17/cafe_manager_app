class ReportModel {
  String ban;
  String hour;
  String idMon;
  String idTypeMon;
  String soLuongMon;
  String time;
  int tongTien;
  String tenMon;
  int timestamp;

  ReportModel(
      {this.ban,
      this.hour,
      this.idMon,
      this.idTypeMon,
      this.soLuongMon,
      this.time,
      this.tenMon,
      this.timestamp,
      this.tongTien});

  ReportModel.fromJson(Map<String, dynamic> json) {
    ban = json['ban'];
    hour = json['hour'];
    idMon = json['idMon'];
    tenMon = json['tenMon'];
    timestamp= json['timestamp'];
    idTypeMon = json['idTypeMon'];
    soLuongMon = json['soLuongMon'];
    time = json['time'];
    tongTien = json['tongTien'];
  }
}
