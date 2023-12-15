import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallImageTemplate extends StatelessWidget {
  const SmallImageTemplate(
      {Key? key,
      Map<String, dynamic>? extParams,
      required this.list,
      required this.title,
      required this.changeCallBack})
      : super(key: key);

  final List<Map> list;
  final String? title;
  final void Function(int index) changeCallBack;

  //
  // @override
  // WidgetInfos widgetInfos() {
  //   return WidgetInfos(
  //       name: '小图模板',
  //       description: '小图模板描述',
  //       widgetVersion: '1.0.1',
  //       positionType: ComponentPositionType(
  //           ComponentPositionType.positionTypeValueStatic),
  //       widgetAllowPlatformType: WidgetAllowPlatformType(
  //           WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
  //       isAllowRepeat: true,
  //       isEditable: true,
  //       fieldList: []);
  // }

  // @override
  // Map<String, ExtParamInfos> privateExtParams() {
  //   return {};
  // }
  //
  // @override
  // Map<String, EventInfos> privateDatasourceEvents() {
  //   return {};
  // }

  printNumber() {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(Container(
        margin: EdgeInsets.only(right: 8.0.w),
        child: ImageText(
          image: list[i]['url'],
          text: list[i]['name'],
          persons: list[i]['playNum'] ?? 10000,
          onClick: () {
            // changeCallBack(list[i]);
            changeCallBack(i);
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
      width: 360.w,
      padding: EdgeInsets.fromLTRB(0, 12.0.h, 0, 20.w),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage(R.homebgBgMeirituijian, package: 'flutter_lib_shared'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 20.0.h,
            padding: EdgeInsets.only(left: 20.0.w),
            child: Text(
              title ?? '每日推荐',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 120.w,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.0.w, right: 12.0.w),
              children: <Widget>[
                printNumber(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _RecommendState extends State<Recommend> {
// }

class ImageText extends StatelessWidget {
  const ImageText({
    Key? key,
    this.image,
    this.text,
    this.onClick,
    this.persons,
  }) : super(key: key);

  final String? image;
  final String? text;
  final dynamic persons;
  final dynamic onClick;

  // 向上取整 (向下取整truncateToDouble)
  // ignore: avoid_types_as_parameter_names
  // String upperNum(num) {
  //   if (num < 100000) return "$num";
  //   return "${(num / 10000).toStringAsFixed(1)}w";
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '$image',
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width: 88.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0.w),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              R.smallImage,
              package: 'flutter_lib_shared',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 88.0.w,
              height: 52.0.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0),
                      Color.fromRGBO(0, 0, 0, 0.6)
                    ]),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0.w),
                  bottomRight: Radius.circular(12.0.w),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  20.vGap,
                  SizedBox(
                    width: 88.0.w,
                    height: 13.0.w,
                    child: Center(
                      child: Text(
                        '$text',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0.sp,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  2.vGap,
                  SizedBox(
                    width: 88.0.w,
                    height: 13.0.h,
                    child: Center(
                      child: Text(
                        '$persons人在玩',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 8.0.sp,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  2.vGap
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
