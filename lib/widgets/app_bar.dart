import '../common/exports/common_lib.dart';

///@author huangjianghe
///@date 2022/7/20
///@description 通用AppBar
// class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final Widget? rightWidget;
//   final Widget? leftWidget;
//
//   const MyAppBar({Key? key, this.rightWidget, this.leftWidget})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset(
//             R.regIconClosTitle,
//             package: 'flutter_lib_shared',
//           ),
//           leftWidget ?? Container(),
//           rightWidget ?? Container(),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(88.h);
// }

class ScaffoldWrapper extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? centerWidget;
  final bool isShowBack;
  final Function? popCallback;
  final Color titleColor;
  final Color appBgColor;
  final Color barBgColor;
  final dynamic result;
  final Widget? drawerWidget;
  final double elevation;
  final Color? shadowColor;
  final Widget? flexibleSpace;
  final double? leadingWidth;

  const ScaffoldWrapper(
      {Key? key,
      this.title,
      required this.body,
      this.actions,
      this.leading,
      this.isShowBack = true,
      this.popCallback,
      this.titleColor = AppColors.c333333,
      this.appBgColor = AppColors.white,
      this.barBgColor = AppColors.white,
      this.drawerWidget,
      this.centerWidget,
      this.elevation = 0,
      this.shadowColor,
      this.result,
      this.leadingWidth,
      this.flexibleSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leftWidget;
    if (isShowBack) {
      leftWidget = leading;
      leftWidget ??= GestureDetector(
        // icon:
        // color: AppColors.c202020,
        child: const Icon(Icons.arrow_back_ios, color: AppColors.c333333)
            .paddingOnly(left: 5),
        onTap: () {
          popCallback != null ? popCallback!() : Get.back(result: result);
        },
      );
    }

    return Scaffold(
        backgroundColor: appBgColor,
        resizeToAvoidBottomInset: true,
        endDrawer: drawerWidget,
        appBar: AppBar(
          leadingWidth: leadingWidth,
          leading: leftWidget,
          actions: actions,
          titleSpacing: 0.0,

          title: centerWidget ??
              Text(
                title ?? '',
                style: 16.w7(color: titleColor),
              ),
          centerTitle: true,
          //加了platform: TargetPlatform.iOS标题默认居中显示，设置false靠左显示
          // backgroundColor: ThemeColors.colorF2F2F2,
          backgroundColor: barBgColor,
          elevation: elevation,
          shadowColor: shadowColor ?? AppColors.cF0F0F0,
          flexibleSpace: flexibleSpace,
        ),
        // body: NetworkListener(
        //   child: body,
        // ));
        body: body);
  }
}

class NetworkListener extends StatefulWidget {
  final Widget child;

  const NetworkListener({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NetworkListenerState();
  }
}

class _NetworkListenerState extends State<NetworkListener> {
  // late StreamSubscription _subscription;

  // late Stream<ConnectivityResult> results;
  // late Future<ConnectivityResult> results;

  @override
  void initState() {
    super.initState();
    // _subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //
    //   }
    // });
    // results = checkNetState();
  }

  // bool checkNetState() async {
  //   ConnectivityResult connectState = await Connectivity().checkConnectivity();
  //   if (connectState == ConnectivityResult.none) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   builder:
    //       (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
    //     // if(snapshot.connectionState)
    //     logD("网络连接状态=${snapshot.data}");

    //     if (snapshot.hasData && snapshot.data == ConnectivityResult.none) {
    //       return Center(child: Text("网络异常"));
    //     }
    //     return widget.child;
    //   },
    //   future: Connectivity().checkConnectivity(),
    // );
    return widget.child;
  }
}

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool isLeading;
  final Color titleColor;
  final Color barBgColor;

  const TitleBar(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.isLeading = true,
      this.titleColor = AppColors.c333333,
      this.barBgColor = AppColors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leftWidget;
    if (isLeading) {
      leftWidget = leading;
      leftWidget ??= IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: AppColors.c202020,
        onPressed: () {
          Get.back();
        },
      );
    }
    return AppBar(
      leading: leftWidget,
      actions: actions,
      title: Text(
        title ?? '',
        style: TextStyle(color: titleColor),
      ),
      centerTitle: true,
      //加了platform: TargetPlatform.iOS标题默认居中显示，设置false靠左显示
      // backgroundColor: ThemeColors.colorF2F2F2,
      backgroundColor: barBgColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(88.h);
}

class SliverAppBarWrapper extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool isLeading;
  final Color titleColor;
  final Color barBgColor;
  final Color iconColor;
  final bool isChange;
  final bool changeTitleColor;
  final NavBarController? navBarController;

  const SliverAppBarWrapper(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.titleColor = AppColors.c333333,
      this.iconColor = AppColors.c333333,
      this.isLeading = true,
      this.barBgColor = Colors.white,
      this.isChange = false,
      this.titleWidget,
      this.navBarController,
      this.changeTitleColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getBar(Color barColor, Color titleColor) {
      Widget? leftWidget;
      if (isLeading) {
        leftWidget = leading;
        leftWidget ??= IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: titleColor,
          onPressed: () {
            Get.back();
          },
        );
      }

      return SliverAppBar(
        backgroundColor: barColor,
        leading: leftWidget,
        title: titleWidget ??
            Text(
              title ?? "",
              style: 16.w7(color: titleColor),
            ),
        centerTitle: true,
        pinned: true,
        floating: true,
        titleSpacing: 5,
        actions: actions,
      );
    }

    if (isChange) {
      NavBarController controller;
      if (navBarController == null) {
        controller = Get.find();
      } else {
        controller = navBarController!;
      }
      return Obx(() => getBar(controller.barColor.value,
          changeTitleColor ? controller.titleColor.value : titleColor));
    }
    return getBar(barBgColor, titleColor);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool isLeading;
  final Color titleColor;
  final Color barBgColor;
  final Color iconColor;
  final bool isChange;
  final bool changeTitleColor;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.titleColor = AppColors.c333333,
      this.iconColor = AppColors.c333333,
      this.isLeading = true,
      this.barBgColor = Colors.white,
      this.isChange = false,
      this.changeTitleColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getBar(Color barColor, Color titleColor) {
      Widget? leftWidget;
      if (isLeading) {
        leftWidget = leading;
        leftWidget ??= IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: titleColor,
          onPressed: () {
            Get.back();
          },
        );
      }

      return Container(
        color: barColor,
        height: 88,
        width: Get.width * 3 / 4,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftWidget!,
            Text(
              title ?? "",
              style: 16.w7(color: titleColor),
            ),
            ...?actions
          ],
        ),
      );
    }

    if (isChange) {
      NavBarController navBarController = Get.find();
      return Obx(() => getBar(navBarController.barColor.value,
          changeTitleColor ? navBarController.titleColor.value : titleColor));
    }
    return getBar(barBgColor, titleColor);
  }

  @override
  Size get preferredSize => Size.fromHeight(88.h);
}

class NavBarController extends GetxController {
  final scrollControl = ScrollController();

  Rx<Color> barColor = Colors.transparent.obs;
  Rx<Color> titleColor = Colors.white.obs;
  Rx<Color> iconColor = Colors.white.obs;
  bool isUp = false;
  late Color color;
  late Color tColor;

  Color defaultBarColor = Colors.white;

  Color defaultTitleColor = AppColors.c333333;
  @override
  void onInit() {
    scrollControl.addListener(_listener);
    super.onInit();
  }

  void _listener() {
    double offset = scrollControl.offset;
    //上次方向
    bool tempBool = isUp;
    if (offset > 0) {
      double scale = offset / (88 + ScreenUtil().statusBarHeight);
      if (scale > 1) scale = 1;
      barColor.value = defaultBarColor.withOpacity(scale);
      titleColor.value = defaultTitleColor; //上啦
      iconColor.value = defaultTitleColor; //上啦
      isUp = true;
    } else {
      barColor.value = Colors.transparent; //下拉
      titleColor.value = AppColors.white;
      iconColor.value = AppColors.white;
      isUp = false;
    }
    // if (isUp || (isUp == false && isUp != tempBool)) {
    //   // logD("===========$offset");
    //   barColor.value = color;
    //
    //   titleColor.value = tColor;
    //   iconColor.value = tColor;
    // }
  }

//      double offset = mWelfrePageController.xScrollOffset.value;
//       offset = max(0, offset);
//       offset = min(bgHeight, offset);
//       double opacity = offset / bgHeight;
  @override
  void onClose() {
    scrollControl.removeListener(_listener);
    super.onClose();
  }
}
