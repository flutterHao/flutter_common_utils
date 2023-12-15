import 'package:flutter/material.dart';

///@author huangjianghe
///@date 2022/7/28
///@description 拓展widget功能
extension WidgetExt on Widget {
  Widget setSized(
          {double width = double.infinity, double height = double.infinity}) =>
      SizedBox(
        width: width,
        height: height,
        child: this,
      );

  Widget setContainer(
          {double paddingVertical = 0.0,
          double paddingHorizontal = 0.0,
          double? height,
          double? width}) =>
      Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: this,
      );
}
