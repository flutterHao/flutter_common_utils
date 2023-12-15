///游戏首页轮播
///@author lihonghao
///@date 2022/06/22
///问题：存在文字内容过长导致其他空间超出的问题（待修改）
import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/r.dart';

// ignore: must_be_immutable
class SwiperGameCard extends AbsBaseComponent {
  SwiperGameCard({
    Key? key,
    required Map<String, dynamic> extParams,
  }) : super(key: key, extParams: extParams);

  late int counter;

  @override
  void dump() {}

  @override
  Map<String, EventInfos> privateDatasourceEvents() {
    return {};
  }

  @override
  Map<String, ExtParamInfos> privateExtParams() {
    return {};
  }

  @override
  WidgetInfos widgetInfos() {
    return WidgetInfos(
        name: '轮播卡片',
        description: '轮播卡片描述',
        widgetVersion: '1.0.1',
        positionType: ComponentPositionType(
            ComponentPositionType.positionTypeValueStatic),
        widgetAllowPlatformType: WidgetAllowPlatformType(
            WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
        isAllowRepeat: true,
        isEditable: true,
        fieldList: []);
  }

  @override
  Widget build(BuildContext context) {
    // return Container(width: 300.w, height: 200.w, color: Colors.yellow,);
    // return Scaffold(
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 229.w,
                height: 22.h,
                child: _customText("High Bonus Games",
                    fontsize: 16.sp, color: AppColors.c202020),
              ),
              SizedBox(width: 57.w),
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "See All");
                },
                child: SizedBox(
                  width: 42.w,
                  height: 18.h,
                  child: _customText("See All",
                      fontsize: 12.sp,
                      color: AppColors.c8423FF,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Container(
            height: 180.h,
            width: 332.w,
            margin: EdgeInsets.only(top: 8.h),
            child: PageView(
              children: [_rotation(), _rotation(), _rotation()],
            ),
          ),
        ],
      ),
    );
    // );
  }

  Widget _rotation() {
    return SizedBox(
      height: 184.h,
      width: 328.w,
      child: Stack(
        children: [
          _gameInfo(),
          _gameImageShow(),
          _titleBackGroud(),
        ],
      ),
    );
  }

  Widget _titleBackGroud() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(R.regIconNotChecked,
                    package: 'flutter_lib_shared'))),
        width: 120.w,
        height: 28.h,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          child: Text(
            "GRAND￥100",
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _gameImageShow() {
    return Positioned(
        left: 16.w,
        bottom: 38.h,
        child: Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.w),
              ),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F4k%2Fs%2F01%2F210924141301AZ-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1658484316&t=4e3522669ae1ba07eb1a6baf797fd71e"))),
        ));
  }

  Widget _gameInfo() {
    return Container(
      width: 328.w,
      height: 180.h,
      margin: EdgeInsets.only(top: 4.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(colors: [
          Color(0xFFF1FAFF),
          Color(0xFFF9E8FF),
        ]),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(130.w, 20.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText(
              "BackOut Bingo Test ",
              fontsize: 14.sp,
              color: Colors.black,
            ),
            SizedBox(height: 2.h),
            _detailInfoText(R.fnmainIconTime, "11.00 am,Apr 20 - 11:30 Apr 22"),
            _detailInfoText(R.fnmainIconPeople, "110/1500 Players"),
            Row(
              children: [
                _detailInfoText(R.fnmainIconEntryAmount, "11.00 am "),
                SizedBox(width: 5.w),
                Expanded(
                  child: _detailInfoText(R.fnmainIconSubstitute, "200 "),
                )
              ],
            ),
            Row(
              children: [
                _detailInfoText(R.fnmainIconAward, "11.00 "),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "see more");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 4.h, left: 20),
                    child:
                        _customText("See more", color: const Color(0xFFA965FF)),
                  ),
                )
              ],
            ),
            _bottomButton()
          ],
        ),
      ),
    );
  }

  Widget _detailInfoText(String imagePath, String text, {Color? color}) {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 12.w,
            height: 12.w,
            child: Image.asset(imagePath, package: 'flutter_lib_shared'),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: color ?? AppColors.c565656,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _customText(String text,
      {double? fontsize, Color? color, FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? AppColors.c565656,
          fontSize: fontsize ?? 10.sp,
          fontWeight: fontWeight ?? FontWeight.w700),
    );
  }

  Widget _bottomButton() {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: "win 200");
      },
      child: Container(
        width: 91.w,
        height: 32.h,
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              colors: [Color(0xFF0BD3FF), Color(0xFF9846FF)]),
        ),
        child: Center(
          child: _customText("Win ￥200", fontsize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }
}
