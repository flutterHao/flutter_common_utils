import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';

///@author zhangfuyang
///@date 2022/06/23
///
/// "热门搜索"组件
class HotSearch extends StatelessWidget {
  const HotSearch({
    Key? key,
    this.title,
    this.list,
    this.changeCallBack,
  }) : super(key: key);

  final dynamic title;
  final dynamic list;
  final dynamic changeCallBack;

  boxList() {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(
        InkWell(
          onTap: () {
            changeCallBack(list[i]);
          },
          child: SizedBox(
            width: 144.0.w,
            height: 20.0.h,
            child: Row(
              children: [
                Container(
                  width: 20.0.w,
                  alignment: Alignment.center,
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: i < 3 ? FontWeight.w900 : FontWeight.w400,
                      color:
                          i < 3 ? const Color(0xFFA056FF) : AppColors.c999999,
                    ),
                  ),
                ),
                Container(
                  width: 124.0.w,
                  padding: EdgeInsets.only(left: 4.0.w),
                  child: Text(
                    "${list[i]['name']}",
                    softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 10.h),
      child: Stack(
        children: [
          Container(
            width: 320.0.w,
            height: 220.0.h,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFEAF3),
                    Color(0xFFFBF6FF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: 12.br),
          ),
          Image.asset(
            R.regBgTopSearch,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 50,
            top: 18,
            child: Text(
              '热门搜索',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 50,
            child: Container(
              width: 320.0.w,
              margin: EdgeInsets.only(top: 10.0.h),
              child: Wrap(
                // spacing: 2, // 主轴上子控件的间距
                runSpacing: 12, // 交叉轴上子控件之间的间距
                children: boxList(), // 要显示的子控件集合
              ),
            ),
          )
        ],
      ),
    );
  }
}
