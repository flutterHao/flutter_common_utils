import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import 'image_show_widget.dart';

///@author Hao
///@date 2022/6/10
///菜单组件

typedef MenuOnTap = void Function(int index);

class MenuListView extends StatelessWidget {
  MenuListView(
      {Key? key, required this.menus, this.onTap, this.imageFailedPath})
      : super(
          key: key,
        );

  final List<Map> menus;
  final MenuOnTap? onTap;
  final String? imageFailedPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 10.h, top: 15.h),
      width: 312.w,
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: 5,
        crossAxisSpacing: 25.h,
        mainAxisSpacing: 10.w,
        childAspectRatio: 8.w / 10.w,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: menus.asMap().keys.map((index) => _buildItem(index)).toList(),
      ),
    );
  }

  Widget _buildItem(index) {
    String name = menus[index][ConstantComponent.name] ?? '';
    return GestureDetector(
      onTap: () {
        onTap!(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: 88,
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: ImageWidget(
                  url: menus[index][ConstantComponent.url],
                )),
            Expanded(
              flex: 2,
              child: Text(
                name,
                // '菜单',
                style: 10.w4(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
