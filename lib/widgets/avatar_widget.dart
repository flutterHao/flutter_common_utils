///@author guanchao.fan
///@date 2022/08/01
///圆角白边头像
///
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.avatarUrl,
      required this.borderWidth,
      required this.borderRadius,
      this.borderColor})
      : super(key: key);

  final double width;
  final double height;
  final double borderWidth;
  final double borderRadius;
  final Color? borderColor;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    double innerBorderRadius =
        (height - borderWidth * 2) * borderRadius / height;
    return Container(
        width: width, // 60.w,
        height: height, // 60.w,
        child: Stack(
          children: [
            Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // 边色与边宽度
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 1.w,
                  //     spreadRadius: 1,
                  //     color: Colors.red.withOpacity(0.5),
                  //   ),
                  // ]
                )),
            // ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            //   child: Container(
            //     width: width, // 60.w,
            //     height: height, // 60.w,
            //     color: borderColor ?? Colors.white, // Colors.white,
            //   ),
            // ),
            Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(innerBorderRadius)),
                child: Container(
                  width: width - borderWidth * 2, // 56.w,
                  height: height - borderWidth * 2, // 56.w,
                  // color: Colors.yellow,
                  child: Container(
                    color: borderColor ?? Colors.white,
                    child: CachedNetworkImage(
                      imageUrl:
                          avatarUrl, // 'https://pic4.zhimg.com/v2-6df5bbd6be9942b53dbd638acc18ebe6_r.jpg?source=1940ef5c',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
