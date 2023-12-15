import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/utils/data_util.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

import '../../generated/r.dart';

typedef OnTapHeader = void Function(int index);

///@author huangjianghe
///@date 2022/6/30
///头部固定的listview
class ListViewStickyHeader<T> extends StatelessWidget {
  final List  dataList;
  final Widget? header;
  final Widget? refreshHeader;
  final Widget? refreshFooter;
  final ScrollPhysics? physics;
  final OnTapHeader onTapHeader;
  final Widget Function(int index, T t) itemBuilder;

  ListViewStickyHeader(
      {Key? key,
        required this.dataList,
        this.refreshHeader,
        this.physics,
        this.refreshFooter,
        required this.onTapHeader,
        this.header,
        required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (header != null) {
      dataList.insert(0, 'header');
    }
    return FlutterSliverList(
        delegate: FlutterListViewDelegate(initOffset: 188, (context, index) {
          var data = dataList[index];
          if (data is String) {
            return header;
          }
          if (data is AlphabetHeader) {
            return _renderHeader(data.name, context);
          }
          return itemBuilder(index, data as T);
        },
            childCount: dataList.length,
            onItemSticky: (index) => dataList[index] is AlphabetHeader,
            keepPosition: true,
            onItemHeight: (index) => 72.h));
  }



  Widget _renderHeader(String text, context) {
    return Container(
      color: AppColors.cF0F0F0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: GestureDetector(
          onTap: () {
            onTapHeader(1);
          },
          child: Row(
            children: [
              Text(
                text,
                style: AppTextStyles.tsW700.copyWith(fontSize: 12.sp),
              ),
              ImageUtil.asset(R.regIconExpand)
            ],
          ),
        ),
      ),
    );
  }

}
