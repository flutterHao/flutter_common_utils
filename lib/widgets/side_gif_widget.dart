import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../generated/r.dart';

///author:lihonghao
///discript:滚动位置变动礼包

class SideGifWidget extends AbsBaseComponent {
  SideGifWidget({
    Key? key,
    // required Map<String, dynamic> extParams,
    required this.childWidget,
    required this.onTap,
  }) : super(key: key);
  final Widget childWidget;
  final Function onTap;

  @override
  void dump() {}

  @override
  WidgetInfos widgetInfos() {
    return WidgetInfos(
        name: '礼物',
        description: '礼物',
        widgetVersion: '1.0.1',
        positionType: ComponentPositionType(
            ComponentPositionType.positionTypeValueNotify),
        widgetAllowPlatformType: WidgetAllowPlatformType(
            WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
        isAllowRepeat: false,
        isEditable: true,
        fieldList: []);
  }

  @override
  Map<String, ExtParamInfos> privateExtParams() {
    return {};
  }

  @override
  Map<String, EventInfos> privateDatasourceEvents() {
    return {};
  }

  // final mSideGifWidgetController = SideGifWidgetController();
  RxBool isScrollUpdate = false.obs;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          bool flag = notification is ScrollUpdateNotification;
          if (notification.metrics.axis == Axis.vertical) {
            isScrollUpdate.value = flag;
          }
          return true;
        },
        child: Stack(
          children: [childWidget, _sideGif()],
        ));
  }

  Widget _sideGif() {
    return Obx(
      () => Positioned(
        left: isScrollUpdate.value ? 330.w : 285.w,
        bottom: 180.w,
        width: 74.w,
        height: 77.w,
        child: InkWell(
          onTap: () => onTap(),
          child: Image.asset(
            R.redPacket,
            fit: BoxFit.fitHeight,
            package: 'flutter_lib_shared',
          ),
        ),
      ),
    );
  }

  // Widget _clipWidget() {
  //   return Positioned(
  //     bottom: 227.h,
  //     left: 330.w,
  //     width: 74.w,
  //     height: 77.h,
  //     child: InkWell(
  //         onTap: () {},
  //         child: Image.asset(R.homebgGuideXuanfuchuang,
  //             fit: BoxFit.fitHeight, package: 'flutter_lib_shared')),
  //   );
  // }
}

class SideGifWidgetController extends GetxController {
  RxBool xIsScrollUpdate = false.obs;
  changeScroll(bool isScrollupdate) {
    xIsScrollUpdate.value = isScrollupdate;
  }
}

// class AnimationGifWidget extends StatefulWidget {
//   const AnimationGifWidget({
//     Key? key,
//     // required Map<String, dynamic> extParams,
//     required this.childWidget,
//     required this.onTap,
//   }) : super(key: key);
//   final Widget childWidget;
//   final Function onTap;

//   @override
//   State<AnimationGifWidget> createState() => _AnimationGifWidgetState();
// }

// class _AnimationGifWidgetState extends State<AnimationGifWidget>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   RxBool _isScroller = false.obs;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           bool flag = notification is ScrollUpdateNotification;
//           if (notification.metrics.axis == Axis.vertical) {
//             _isScroller.value = flag;
//           }
//           return true;
//         },
//         child: Stack(
//           children: [
//             widget.childWidget,
//             // InkWell(
//             //   onTap: () => widget.onTap(),
//             //   child: InkWell(
//             //       onTap: () {},
//             //       child: Image.asset(R.homebgGuideXuanfuchuang,
//             //           fit: BoxFit.fitHeight, package: 'flutter_lib_shared')),
//             // )
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: SlideTransition(
//                     position: _isScroller.value
//                         ? Tween<Offset>(
//                             begin: Offset(0, 0),
//                             end: Offset(200, 400),
//                           ).animate(_controller)
//                         : Tween<Offset>(
//                             begin: Offset(200, 400),
//                             end: Offset(0, 0),
//                           ).animate(_controller),
//                     child: InkWell(
//                       onTap: () => widget.onTap(),
//                       child: InkWell(
//                           onTap: () {},
//                           child: Image.asset(R.homebgGuideXuanfuchuang,
//                               fit: BoxFit.fitHeight,
//                               package: 'flutter_lib_shared')),
//                     )))
//           ],
//         ));
//   }
// }
