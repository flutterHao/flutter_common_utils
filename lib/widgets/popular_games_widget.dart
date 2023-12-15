// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@author zhangfuyang
///@date 2022/06/23
/// 国外
/// "PopularGames"组件
class PopularGames extends StatelessWidget {
  const PopularGames({
    Key? key,
    this.list,
    this.title,
    this.image,
    this.changeCallBack,
  }) : super(key: key);

  final dynamic list;
  final dynamic title;
  final dynamic image;
  final dynamic changeCallBack;

  printNumber() {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(
        Card(
          image: list[i]['image'],
          name: list[i]['name'],
          introduction: list[i]['introduction'],
          welfare: list[i]['welfare'],
          onClick: () {
            changeCallBack(list[i]);
          },
        ),
      );
    }

    return GridView.count(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      crossAxisSpacing: 8.0.h,
      mainAxisSpacing: 8.0.w,
      childAspectRatio: 1.h / 2.w,
      children: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0.w,
      height: 230.0.h,
      padding: EdgeInsets.fromLTRB(0, 16.0.h, 0, 16.0.h),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: NetworkImage('$image'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      color: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 20.0.h,
            padding: EdgeInsets.only(left: 20.0.w),
            child: Text(
              title,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            width: 360.0.w,
            height: 168.0.h,
            child: printNumber(),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
    this.image,
    this.name,
    this.introduction,
    this.welfare,
    this.onClick,
  }) : super(key: key);

  final dynamic image;
  final dynamic name;
  final dynamic introduction;
  final dynamic welfare;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0.w, 7.0.h, 10.0.w, 12.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0.w),
        ),
      ),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 61.0.w,
              height: 61.0.h,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.0.h),
                    width: 56.0.w,
                    height: 56.0.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('$image'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0.w),
                      ),
                    ),
                    // color: Colors.pink,
                  ),
                  welfare == true
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: SizedBox(
                            width: 23.0.w,
                            height: 23.0.h,
                            child: Image.asset(R.bomtabIconClickFuli, package: 'flutter_lib_shared',),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(width: 4.0.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 75.0.w,
                  child: Text(
                    '$name',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 75.0.w,
                  child: Text(
                    '$introduction',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
