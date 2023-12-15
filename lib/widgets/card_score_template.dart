import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_show_widget.dart';


class CardScoreTemplate extends StatelessWidget {
  CardScoreTemplate(
      {Key? key,
      required this.list,
      required this.title,
      required this.changeCallBack})
      : super(key: key);

  late List list;
  late dynamic title;
  final Function(int index) changeCallBack;

  // @override
  // void dump() {}

  // @override
  // WidgetInfos widgetInfos() {
  //   return WidgetInfos(
  //       name: '高评分游戏',
  //       description: '高评分游戏',
  //       widgetVersion: '1.0.1',
  //       positionType: ComponentPositionType(
  //           ComponentPositionType.positionTypeValueStatic),
  //       widgetAllowPlatformType: WidgetAllowPlatformType(
  //           WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
  //       isAllowRepeat: true,
  //       isEditable: true,
  //       fieldList: []);
  // }
  //
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
      data.add(
        Card(
          image: list[i]['url'],
          name: list[i]['name'],
          introduction: list[i]['introduction'],
          score: list[i]['score'] ?? '0',
          onClick: () {
            changeCallBack(i);
          },
        ),
      );
    }

    return GridView.count(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      crossAxisSpacing: 8.0.h,
      mainAxisSpacing: 8.0.w,
      childAspectRatio: 8.h / 20.w,
      children: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    title ??= '高评分游戏';
    return Container(
      width: 360.w,
      padding: EdgeInsets.fromLTRB(0, 12.0.h, 0, 12.0.h),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage(R.homebgBgGaopingfen, package: 'flutter_lib_shared'),
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
              title,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          SizedBox(height: 8.0.h),
          SizedBox(
            width: 360.0.w,
            height: 180.w,
            child: printNumber(),
          ),
        ],
      ),
    );
  }
}

// class _CardScoreTemplateState extends State<CardScoreTemplate> {
// }

class Card extends StatelessWidget {
  const Card({
    Key? key,
    this.image,
    this.name,
    this.introduction,
    this.score,
    this.onClick,
  }) : super(key: key);

  final dynamic image;
  final dynamic name;
  final dynamic introduction;
  final dynamic score;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0.w),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 226, 214, 0.5),
              offset: Offset(0, 4), //阴影y轴偏移量
              blurRadius: 4, //阴影模糊程度
            )
          ]),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: <Widget>[
            ImageWidget(
              url: image,
              height: 57,
              width: 57,
              borderRadius: 12.br,
            ),
            8.hGap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 120.w,
                    height: 18.w,
                    child: Text(
                      '$name',
                      style: 12.w7(),
                    ),
                  ),
                  Text(
                    '$introduction',
                    style: 10.w4(color: AppColors.c666666),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   width: 140.w,
                  //   child: Text(
                  //     '$introduction',
                  //     // softWrap: true,
                  //     // textAlign: TextAlign.left,
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 1,
                  //     style: 10.w4(color: AppColors.c666666),
                  //   ),
                  // ),
                  6.vGap,
                  Container(
                    width: 46.0.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(166, 97, 255, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0.w),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.grade,
                          color: Colors.white,
                          size: 12,
                        ),
                        2.hGap,
                        Text(
                          '$score分',
                          style: 8.w7(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 3),
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
