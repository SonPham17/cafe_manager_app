
import 'package:cafe_manager_app/common/utils/screen_utils.dart';

extension ScreenExtension on num{
  num get w => ScreenUtil().setWidth(this);
  num get h => ScreenUtil().setHeight(this);
  num get sp => ScreenUtil().setSp(this);
}