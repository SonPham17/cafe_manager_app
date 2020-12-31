import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageConstants.backgroundAppbar),

        ],
      ),
    );
  }
}
