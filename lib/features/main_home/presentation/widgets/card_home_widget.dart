import 'package:cafe_manager_app/common/constants/icon_constants.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardHome extends StatelessWidget {
  final String icon;
  final String label;
  final Function onTap;

  CardHome({this.icon, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 100.w,
              height: 100.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black45),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
