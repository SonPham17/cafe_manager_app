import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
