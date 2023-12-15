import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../generated/r.dart';

class LargeImageTemplate extends StatelessWidget {
  final List list;
  final String title;
  final Function(int index) changeCallBack;

  const LargeImageTemplate(
      {Key? key,
      required this.title,
      required this.list,
      required this.changeCallBack})
      : super(key: key);

  // @override
  // WidgetInfos widgetInfos() {
  //   return WidgetInfos(
  //       name: '大图模板',
  //       description: '大图模板描述',
  //       widgetVersion: '1.0.1',
  //       positionType: ComponentPositionType(
  //           ComponentPositionType.positionTypeValueStatic),
  //       widgetAllowPlatformType: WidgetAllowPlatformType(
  //           WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
  //       isAllowRepeat: true,
  //       isEditable: true,
  //       fieldList: []);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
          ).marginOnly(left: 20.w),
          Container(
              margin: EdgeInsets.only(top: 10.w),
              width: 360.w,
              height: 190.w,
              child: buildListView(list))
        ],
      ),
    );
  }

  Widget buildListView(List list) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 20.w),
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // GameRotationModel item = list[index];
          return InkWell(
            onTap: () => changeCallBack(index),
            child: _item(list[index]),
          );
        });
  }

  //游戏展示Item
  Widget _item(Map item) {
    return Card(
      margin: EdgeInsets.only(right: 8.w),
      color: Colors.white,
      elevation: 6,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: SizedBox(
        width: 300.w,
        height: 190.w,
        child: Stack(
          children: [
            _gameShow(item),
            _gameRarkBg(),
            _gameMark(item['score'] ?? '10'),
          ],
        ),
      ),
    );
  }

  //游戏评分
  Widget _gameMark(score) {
    return Positioned(
        top: 21.w,
        child: Container(
          width: 34.w,
          height: 12.w,
          alignment: Alignment.center,
          child: Text(
            "$score分",
            textAlign: TextAlign.center,
            style: 10.w7(),
          ),
        ));
  }

  //星级背景图
  Widget _gameRarkBg() {
    return Positioned(
        child: SizedBox(
      width: 34.w,
      height: 45.w,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
        child: Image.asset(
          R.homebgLabelXingji,
          package: 'flutter_lib_shared',
          fit: BoxFit.fitHeight,
        ),
      ),
    ));
  }

  //游戏展示
  Widget _gameShow(Map item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          height: 140.w,
          width: 300.w,
          imageUrl: "${item['url']}",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              color: const Color(0XFFBFC6FF),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            R.banner,
            package: 'flutter_lib_shared',
            fit: BoxFit.cover,
          ),
        ),
        Container(
            width: 264.w,
            height: 20.w,
            margin: EdgeInsets.only(left: 12.w, top: 8.w),
            child: Text(
              item[ConstantComponent.name],
              style: 14.w4(),
            )),
        Container(
          width: 264.w,
          height: 13.w,
          margin: EdgeInsets.only(left: 12.w, top: 1.w),
          child: _customText("${item['desc']}", 10.sp, AppColors.cB8B8B8),
        ),
      ],
    );
  }

  Text _customText(String text, double fontsize, Color color) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontsize,
          color: color, //Color(color),
          overflow: TextOverflow.clip),
    );
  }
}
