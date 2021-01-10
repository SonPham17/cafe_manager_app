import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:cafe_manager_app/features/main_home/data/models/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cafe_manager_app/common/extensions/my_iterable_extensions.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  DateTime selectedDay;

  final formatter = new DateFormat('dd-MM-yyyy');
  final formatterMoney = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();

    selectedDay = DateTime.now();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Báo cáo doanh thu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              initialSelectedDay: selectedDay,
              calendarController: _calendarController,
              locale: Intl.getCurrentLocale(),
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              calendarStyle: CalendarStyle(
                selectedColor: Colors.deepOrange[400],
                todayColor: Colors.deepOrange[200],
                markersColor: Colors.brown[700],
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonTextStyle:
                    TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onDaySelected: _onDaySelected,
            ),
            StreamBuilder<QuerySnapshot>(
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 30.sp),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      child: Lottie.asset('assets/gifs/loading_gif.json',
                          width: 80, height: 80),
                    ),
                  );
                }

                if (snapshot.data.docs.isEmpty) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text('Dữ liệu đang trống!'),
                    ),
                  );
                }

                var data = snapshot.data.docs;
                final listReport =
                    data.map((e) => ReportModel.fromJson(e.data())).toList();

                var listDayReport = listReport
                    .where((element) =>
                        element.time == formatter.format(selectedDay))
                    .toList();

                var tongTienTrongThang = 0;
                var listMonth = listReport.where((element) {
                  var date = DateFormat('dd-MM-yyyy').parse(element.time);
                  if (date.month == selectedDay.month) {
                    tongTienTrongThang += element.tongTien;
                    return true;
                  } else {
                    return false;
                  }
                }).toList();

                var tongTien = 0;
                listDayReport.forEach((element) {
                  tongTien += element.tongTien;
                });

                if (listDayReport.isEmpty) {
                  return Container(
                    height: 200,
                    margin:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.deepOrange[400],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              'Tổng tiền đã bán được của tháng ${selectedDay.month}: ${formatterMoney.format(tongTienTrongThang)} vnd',
                              style: TextStyle(fontSize: 20),
                            ))
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child:
                                Text('Chưa có đơn hoàn thành nào trong ngày!'),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                listDayReport = listDayReport.sortedBy((e) => e.timestamp);
                return Container(
                  margin:
                      EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.deepOrange[400],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'Tổng tiền đã bán được của tháng ${selectedDay.month}: ${formatterMoney.format(tongTienTrongThang)} vnd',
                            style: TextStyle(fontSize: 20),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.deepOrange[400],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'Tổng tiền đã thu được trong ngày: ${formatterMoney.format(tongTien)} vnd',
                            style: TextStyle(fontSize: 20),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          var mangTenMon =
                              listDayReport[index].tenMon.split(',');
                          var mangSoLuongMon =
                              listDayReport[index].soLuongMon.split(',');

                          var soLuongMonDaGoi = '';
                          mangTenMon.forEach((element) {
                            soLuongMonDaGoi +=
                                ' $element x ${mangSoLuongMon[mangTenMon.indexOf(element)]},';
                          });

                          return Card(
                            elevation: 10,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: AppColors.primaryColor,
                            child: Container(
                              height: 140,
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        listDayReport[index].hour,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '- Bàn số: ${listDayReport[index].ban}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '- Tổng tiền: ${formatterMoney.format(listDayReport[index].tongTien)} vnd',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '- Các món đã order: ${soLuongMonDaGoi.substring(0, soLuongMonDaGoi.length - 1)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: listDayReport.length,
                      ),
                    ],
                  ),
                );
              },
              stream: FirebaseFirestore.instance
                  .collection(FirebaseCollectionConstants.report)
                  .snapshots(),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      selectedDay = day;
    });
    print('CALLBACK: _onDaySelected ${day.month}');
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
    _calendarController.dispose();
  }
}
