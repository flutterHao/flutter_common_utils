import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../generated/r.dart';
import 'custom_textfield.dart';

///@author lihonghao
///@date 2022/6/15
///搜索组件
class SearchNavBar extends StatelessWidget {
  final String titleHint;
  final Color? barColor;
  final Function? onItemTap;

  SearchNavBar({
    Key? key,
    required this.titleHint,
    this.barColor,
    this.onItemTap,
  }) : super(
          key: key,
        );

  // @override
  // WidgetInfos widgetInfos() {
  //   return WidgetInfos(
  //       name: '搜索框',
  //       description: '搜索框',
  //       widgetVersion: '1.0.1',
  //       positionType: ComponentPositionType(
  //           ComponentPositionType.positionTypeValueSliverAppBar),
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

  final searchViewController = SearchViewController();

  @override
  Widget build(BuildContext context) {
    if (barColor != null) {
      searchViewController.xColor.value = barColor!.value;
    } else {
      searchViewController.xColor.value =
          AppColors.white.withOpacity(0.0).value;
    }
    return Obx(() {
      return SliverAppBar(
        backgroundColor: Color(searchViewController.xColor.value),
        // barColor ?? AppColors.white.withOpacity(0.0),
        title: SearchView(
          // titleHint: widget.titleHint,onItemTap:widget.onItemTap,
          titleHint: titleHint,
          onItemTap: () {},
          enabled: false,
          leftImgPath: R.fenleiIconSearch,
          rightImgPath: '',
          width: Get.width,
        ),
        pinned: true,
        floating: true,
        titleSpacing: 5,
      );
    });
  }

  void setBarColor(barColor) {
    // setState(() {
    //   this.barColor = barColor;
    // });
    searchViewController.changeColor(barColor);
  }
}

class SearchViewController extends GetxController {
  RxInt xColor = 0.obs;

  changeColor(Color color) {
    xColor.value = color.value;
  }
}

class SearchView extends StatelessWidget {
  final String titleHint;
  final String? merchantId;
  final bool? isSearchAll;
  final Color? colors;
  final Function? onItemTap;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? leftImgPath;
  final String? rightImgPath;
  final Widget? rightWidget;
  final bool isEmpty;
  final GestureTapCallback? clear;
  final double? width;
  final Color? bgColor;
  final BorderRadius? borderRadius;

  const SearchView(
      {Key? key,
      required this.titleHint,
      this.merchantId,
      this.colors,
      this.onItemTap,
      this.isSearchAll,
      this.enabled = true,
      this.controller,
      this.leftImgPath,
      this.rightImgPath,
      this.rightWidget,
      this.isEmpty = true,
      this.width,
      this.bgColor,
      this.borderRadius,
      this.focusNode,
      this.clear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.white,
        // 边色与边宽度
        borderRadius: borderRadius ?? 12.br,
      ),
      height: 32.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Image.asset(leftImgPath ?? R.fenleiIconSearch,
                color: AppColors.cB8B8B8, package: 'flutter_lib_shared'),
          ),
          // Text(
          //   titleHint,
          //   style: TextStyle(
          //       color: AppColors.cB8B8B8, fontSize: Dimens.middleTetSize.sp),
          // ),
          Expanded(
            child: Container(
                height: 60.h,
                alignment: Alignment.center,
                child: CustomTextField(
                  hintText: titleHint,
                  enabled: enabled,
                  controller: controller,
                  focusNode: focusNode,
                )),
          ),
          rightWidget ?? const SizedBox()
        ],
      ),
    );
  }
}
