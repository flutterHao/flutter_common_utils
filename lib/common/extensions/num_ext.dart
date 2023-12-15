import 'package:flutter/foundation.dart';

import '../exports/common_lib.dart';

///@author huangjianghe
///@date 2022/6/10
///@description 拓展num功能
extension NumExt on num {
  Widget get hGap => SizedBox(width: kIsWeb ? toDouble() : toDouble().w);

  Widget get vGap => SizedBox(height: kIsWeb ? toDouble() : toDouble().w);

  Radius get ra => Radius.circular(kIsWeb ? toDouble() : toDouble().r);

  BorderRadius get br => BorderRadius.all(ra);

  EdgeInsets get ea => EdgeInsets.all(kIsWeb ? toDouble() : toDouble().w);

  Divider get hLine => Divider(
        color: AppColors.cB8B8B8,
        height: toDouble(),
      );

  VerticalDivider get vLine => VerticalDivider(
        color: AppColors.cB8B8B8,
        width: toDouble(),
      );

  TextStyle w7({Color color = AppColors.c333333}) => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: kIsWeb ? toDouble() : toDouble().sp,
      color: color,
      fontFamily: 'PingFang SC');

  TextStyle w4({Color color = AppColors.c333333}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kIsWeb ? toDouble() : toDouble().sp,
      color: color,
      fontFamily: 'PingFang SC');

  TextStyle w9({Color color = AppColors.c333333}) => TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: kIsWeb ? toDouble() : toDouble().sp,
      color: color,
      fontFamily: 'PingFang SC');
}
