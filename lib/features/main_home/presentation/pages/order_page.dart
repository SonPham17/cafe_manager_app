import 'package:cafe_manager_app/common/constants/firebase_collection_constants.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách order'),
        actions: [IconButton(icon: Icon(Icons.add_circle), onPressed: () {})],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(FirebaseCollectionConstants.order)
              .snapshots(),
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
              return Center(
                child: Text(
                  'Hiện chưa có đơn order nào!',
                  style: TextStyle(fontSize: 25.sp),
                ),
              );
            }

            return ListView();
          },
        ),
      ),
    );
  }
}
