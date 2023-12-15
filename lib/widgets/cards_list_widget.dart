// ignore_for_file: file_names

import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///@author zhangfuyang
///@date 2022/06/27
///
/// "CardsList"组件
class CardsList extends StatelessWidget {
  const CardsList({
    Key? key,
    this.title,
    this.image,
    this.list,
    this.changeCallBack,
  }) : super(key: key);

  final dynamic title;
  final dynamic image;
  final dynamic list;
  final dynamic changeCallBack;

  printNumber() {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(Container(
        margin: EdgeInsets.fromLTRB(0, 10.0.h, 0, 10.0.h),
        // color: Colors.white,
        child: ImageText(
          image: list[i]['image'],
          text: list[i]['name'],
          introduction: list[i]['introduction'],
          onClick: () {
            changeCallBack(list[i]);
          },
        ),
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 316.0.h,
      // padding: EdgeInsets.only(),
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 22.0.h,
          bottom: 22.0.h,
        ),
        children: printNumber(),
      ),
    );
  }
}

class ImageText extends StatelessWidget {
  const ImageText({
    Key? key,
    this.image,
    this.text,
    this.introduction,
    this.onClick,
  }) : super(key: key);

  final dynamic image;
  final dynamic text;
  final dynamic introduction;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
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
          ),
          SizedBox(
            width: 182.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$text',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
                Text(
                  '$introduction',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColors.c565656,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 54.0.w,
            height: 26.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.w),
              ),
              color: AppColors.cAC6BFF,
            ),
            child: Center(
              child: Text(
                'GO',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
