// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@author zhangfuyang
///@date 2022/06/23
/// 国外
/// "GamesForYou"组件
class GamesForYou extends StatelessWidget {
  const GamesForYou({
    Key? key,
    this.title,
    this.list,
    this.changeCallBack,
  }) : super(key: key);

  final dynamic title;
  final dynamic list;
  final dynamic changeCallBack;

  printNumber(list) {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(Container(
        margin: EdgeInsets.fromLTRB(0, 0, 18.w, 0),
        child: ImageText(
          image: list[i]['image'],
          text: list[i]['name'],
          welfare: list[i]['welfare'],
          onClick: () {
            changeCallBack(list[i]);
          },
        ),
      ));
    }

    return Row(
      children: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158.0.h,
      // padding: EdgeInsets.only(),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _list(title, list),
        ],
      ),
    );
  }

  Widget _list(title, list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0.w, top: 24.0.h),
          child: Text(
            '$title',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
          ),
        ),
        SizedBox(height: 5.0.h),
        SizedBox(
          height: 90.0.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.0.w, right: 2.0.w),
            children: <Widget>[
              printNumber(list),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageText extends StatelessWidget {
  const ImageText({
    Key? key,
    this.image,
    this.text,
    this.welfare,
    this.onClick,
  }) : super(key: key);

  final dynamic image;
  final dynamic text;
  final dynamic welfare;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 67.0.w,
            height: 67.0.h,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 7.0.h),
                  width: 60.0.w,
                  height: 60.0.h,
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
          SizedBox(height: 4.0.h),
          SizedBox(
            width: 68.0.w,
            height: 16.0.h,
            child: Text(
              '$text',
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
