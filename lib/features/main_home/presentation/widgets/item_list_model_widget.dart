import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:cafe_manager_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cafe_manager_app/common/extensions/screen_extensions.dart';

class ItemListModel extends StatelessWidget {
  final String name;
  final String login;
  final String age;
  final String phone;
  final String image;
  final String address;

  ItemListModel({
    this.name,
    this.login,
    this.age,
    this.phone,
    this.image,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: AppColors.primaryColor,
      child: Container(
        height: 170.h,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h, bottom: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              margin: EdgeInsets.only(right: 20.w),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(image),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ và tên: $name',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Tên đăng nhập: $login',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Ngày sinh: $age',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'SĐT: $phone',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Địa chỉ: $address',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
