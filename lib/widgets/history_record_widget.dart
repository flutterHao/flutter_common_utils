import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';

///@author zhangfuyang
///@date 2022/06/24
///
/// "历史记录"组件
class HistoryRecord extends StatefulWidget {
  final List resultList;
  final GestureTapCallback remove;
  final Function onItemTap;

  const HistoryRecord(
      {Key? key,
      required this.resultList,
      required this.remove,
      required this.onItemTap})
      : super(key: key);

  @override
  _HistoryRecordState createState() => _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20.0.w,
            right: 20.0.w,
            top: 20.h,
            bottom: 20.0.h,
          ),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '历史记录',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: AppColors.c999999,
                    ),
                  ),
                  InkWell(
                    onTap: () => widget.remove(),
                    child: Container(
                      width: 24.0.w,
                      height: 24.0.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(R.regIconDelete,
                              package: 'flutter_lib_shared'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0.h),
                child: _item(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //
  // List resultList = [
  //   // "11111111111111111111111111111111111111111111111111111111111111111111111111111",
  //   // "11111111111111111111111111111111111111111111111111111111111111111111111111111",
  //   "穿搭夏季",
  //   "2022流行穿搭",
  //   "穿搭",
  //   "家常菜",
  //   "文案",
  //   "头像",
  //   "学习",
  //   "跑步",
  //   "游泳",
  //   // "跳操",
  //   "11111111111111111111111111111111111111111111111111111111111111111111111111111",
  //   "学穿花衬衫",
  //   "准备好礼物了吗",
  //   "攻略",
  // ];

  int maxLines = 1;
  bool isExpand = false;

  Widget _item(context) {
    // List list = widget.resultList.length > 10
    //     ? widget.resultList.sublist(0, 10)
    //     : widget.resultList;
    return Container(
      alignment: Alignment.topLeft,
      child: ExtendedWrap(
        maxLines: maxLines,
        runSpacing: 12,
        spacing: 12,
        alignment: WrapAlignment.start,
        overflowWidget: _expandButton(),
        children: widget.resultList.map((e) => _itemView(e)).toList(),
      ),
    );
  }

  Widget _itemView(String text) {
    return GestureDetector(
      onTap: () {
        widget.onItemTap(text);
      },
      child: SizedBox(
        height: 24.0.h,
        child: Container(
          constraints: BoxConstraints(maxWidth: 283.0.w),
          // constraints: BoxConstraints(maxWidth: (isExpand ? 283.0.w : 320.0.w)),
          padding: EdgeInsets.fromLTRB(8.0.w, 3.0.h, 8.0.w, 3.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0.w),
            ),
            color: AppColors.cF0F0F0,
          ),
          child: Text(
            text,
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
      ),
    );
  }

  _expandButton() {
    return GestureDetector(
        onTap: () {
          setState(() {
            isExpand = !isExpand;
            maxLines = (isExpand ? 3 : 1);
          });

          // print("$isExpand ...$maxLines");
        },
        child: Image.asset(
            width: 24.0.w,
            height: 24.0.h,
            isExpand ? R.regIconPutAway : R.regIconExpand));
  }
}
