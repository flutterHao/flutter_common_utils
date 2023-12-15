import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:get/get.dart';

import '../generated/r.dart';

class BottomIconTitleTab extends StatelessWidget {
  BottomIconTitleTab(this.dataSources,
      {Key? key,
      Map<String, dynamic>? extParams,
      required this.getChildPage,
      this.onTapButtom})
      : super(key: key);

  // final List<AbsBottomIconTitleTabItemPage> baseTabItemPages;
  final Widget? Function(String sign, int index) getChildPage;
  void Function(int index)? onTapButtom;

  final List dataSources;

  static String assetsImage = 'assets/images/';

  // @override
  // State<StatefulWidget> createState() {
  //   return _BottomIconTitleTabState();
  // }

  // @override
  // void dump() {}
  //
  // @override
  // WidgetInfos widgetInfos() {
  //   return WidgetInfos(
  //       name: '国内底部tab',
  //       description: '组件描述',
  //       widgetVersion: '1.0.1',
  //       positionType:
  //           ComponentPositionType(ComponentPositionType.positionTypeValueTab),
  //       widgetAllowPlatformType: WidgetAllowPlatformType(
  //           WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
  //       isAllowRepeat: false,
  //       isEditable: true,
  //       fieldList: []);
  // }
  //
  // @override
  // Map<String, ExtParamInfos> privateExtParams() {
  //   return {
  //     'tab_order_signs': ExtParamInfos(
  //         name: 'tab顺序标记',
  //         description: 'tab顺序标记',
  //         dataType: ExtParamInfos.dataTypeListString,
  //         defaultValue: 'home_page,ranking_page,weal_page,mine_page',
  //         paramVersion: '1.0.1')
  //   };
  // }

  // @override
  // Map<String, EventInfos> privateDatasourceEvents() {
  //   return {};
  // }

  final mBottomIconTitleTabController = BottomIconTitleTabController();

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmptyList(dataSources)) {
      return SizedBox();
    }
    List<Widget> pages = [];
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < dataSources.length; i++) {
      String mark = dataSources[i]['mark'];
      TabItemInfo? tabItemInfo = pagesMap[mark];
      BottomNavigationBarItem item = BottomNavigationBarItem(
          icon: Image.asset(tabItemInfo!.tabIconNormal,
              width: 24.0.w, height: 24.0.w, package: 'flutter_lib_shared'),
          activeIcon: Image.asset(tabItemInfo.tabIconSelected,
              width: 24.0.w, height: 24.0.w, package: 'flutter_lib_shared'),
          label: tabItemInfo.defaultTabName,
          tooltip: '');
      items.add(item);
      Widget? page = getChildPage(mark, i);
      if (page != null) {
        pages.add(page);
      }
    }

    return Scaffold(
        // appBar: appBar,
        // backgroundColor: Colors.purpleAccent,
        body: Obx(() {
      return IndexedStack(
        index: mBottomIconTitleTabController.xBottombarIndex.value,
        children: pages,
      );
    }), bottomNavigationBar: Obx(() {
      return BottomNavigationBar(
        selectedLabelStyle: 10.w7(),
        unselectedLabelStyle: 10.w4(),
        unselectedItemColor: AppColors.c999999,
        selectedItemColor: AppColors.cAC6BFF,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 24.0,
        items: items,
        currentIndex: mBottomIconTitleTabController.xBottombarIndex.value,
        onTap: (index) {
          // print(index);
          mBottomIconTitleTabController.xBottombarIndex.value = index;
          if (onTapButtom != null) {
            onTapButtom!(index);
          }
        },
      );
    }));
  }

  Map<String, TabItemInfo> pagesMap = {
    'home_page':
        TabItemInfo('首页', R.bomtabIconNoClickShouye, R.bomtabIconClickShouye),
    'ranking_page':
        TabItemInfo('榜单', R.bomtabIconNoClickBandan, R.bomtabIconClickBangdan),
    'weal_page':
        TabItemInfo('福利', R.bomtabIconNoClickFuli, R.bomtabIconClickFuli),
    'mine_page':
        TabItemInfo('我的', R.bomtabIconNoClickWode, R.bomtabIconClickWode),
  };
}

// class _BottomIconTitleTabState extends State<BottomIconTitleTab> {
//   // int _bottombar_index = 0;

// }

class BottomIconTitleTabController extends GetxController {
  RxInt xBottombarIndex = 0.obs;

  changeBottomBarIndex(int index) {
    xBottombarIndex.value = index;
    print(xBottombarIndex.value);
  }
}

class BottomIconTitleTabItem {
  BottomIconTitleTabItem(this.bottomIconTitleTabItem);

  static const BottomIconTitleTabItemHomePage = 'home_page';
  static const BottomIconTitleTabItemRankingPage = 'ranking_page';
  static const BottomIconTitleTabItemWealPage = 'weal_page';
  static const BottomIconTitleTabItemMinePage = 'mine_page';
  String bottomIconTitleTabItem;
}

abstract class AbsBottomIconTitleTabItemPage extends StatelessWidget {
  const AbsBottomIconTitleTabItemPage({
    Key? key,
  }) : super(key: key);

  void dump();

  BottomIconTitleTabItem bottomIconTitleTabItem();
}
