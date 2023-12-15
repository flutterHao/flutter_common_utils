// import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
// import 'package:flutter_lib_shared/common/exports/common_lib.dart';
// import 'package:flutter_lib_shared/components/bottom_floating_icon_tab.dart';
// import 'package:get/get.dart';
//
// import '../generated/r.dart';
//
// // ignore: must_be_immutable
// class TopScrollTitleTab extends AbsBaseComponent {
//   TopScrollTitleTab({
//     Key? key,
//     required Map<String, dynamic> extParams,
//     required this.getChildPage,
//     required this.onMenuTap,
//     required this.endDrawer,
//   }) : super(key: key, extParams: extParams);
//   AbsTopScrollTitleTabItemPage? Function(String sign, int index) getChildPage;
//   void Function() onMenuTap;
//   final Widget endDrawer;
//
//   @override
//   void dump() {}
//
//   @override
//   Map<String, EventInfos> privateDatasourceEvents() {
//     return {
//       'event_sign_2': EventInfos(extParamInfos: {
//         'param_1': ExtParamInfos(
//             name: '参数1',
//             description: '参数1',
//             dataType: ExtParamInfos.dataTypeListString,
//             defaultValue: 'aabbcc',
//             paramVersion: '1.0.1')
//       })
//     };
//   }
//
//   @override
//   Map<String, ExtParamInfos> privateExtParams() {
//     return {
//       'tab_order_signs': ExtParamInfos(
//           name: 'tab顺序标记',
//           description: 'tab顺序标记',
//           dataType: ExtParamInfos.dataTypeListString,
//           defaultValue:
//               'all_games,other_classify,other_classify,other_classify,other_classify,other_classify',
//           paramVersion: '1.0.1'),
//       'tab_order_titles': ExtParamInfos(
//           name: 'tab顺序标题',
//           description: 'tab顺序标题',
//           dataType: ExtParamInfos.dataTypeListString,
//           defaultValue: 'All Games,Cards,Casual,Sports,Board,Puzzle',
//           paramVersion: '1.0.1')
//     };
//   }
//
//   @override
//   WidgetInfos widgetInfos() {
//     return WidgetInfos(
//         name: '外国顶部tab',
//         description: '外国顶部tab描述',
//         widgetVersion: '1.0.1',
//         positionType:
//             ComponentPositionType(ComponentPositionType.positionTypeValueTab),
//         widgetAllowPlatformType: WidgetAllowPlatformType(
//             WidgetAllowPlatformType.widgetAllowPlatformTypeBoth),
//         isAllowRepeat: false,
//         isEditable: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomTabController(
//       mainWidget: context.widget,
//     );
//   }
// }
//
// class CustomTabController extends StatefulWidget {
//   const CustomTabController({Key? key, required this.mainWidget})
//       : super(
//           key: key,
//         );
//   final Widget mainWidget;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _CustomTabControllerState();
//   }
// }
//
// class _CustomTabControllerState extends State<CustomTabController>
//     with TickerProviderStateMixin {
//   static Size boundingTextSize(String text, TextStyle style,
//       {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
//     if (text == null || text.isEmpty) {
//       return Size.zero;
//     }
//     final TextPainter textPainter = TextPainter(
//         textDirection: TextDirection.ltr,
//         text: TextSpan(text: text, style: style),
//         maxLines: maxLines)
//       ..layout(maxWidth: maxWidth);
//     return textPainter.size;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     late TabController tabController;
//     final foreignVerTopTabController = ForeignVerTopTabController();
//
//     CustomTabController mCustomTabController =
//         context.widget as CustomTabController;
//
//     TopScrollTitleTab mTopScrollTitleTab =
//         mCustomTabController.mainWidget as TopScrollTitleTab;
//     Map<String, dynamic> extParams = mTopScrollTitleTab.extParams;
//
//     String tabOrderSignsStr = extParams['tab_order_signs'] ?? '';
//     String tabOrderTitlesStr = extParams['tab_order_titles'] ?? '';
//     List<String> tabOrderSigns = tabOrderSignsStr.split(',');
//     List<String> tabOrderTitles = tabOrderTitlesStr.split(',');
//
//     List<AbsTopScrollTitleTabItemPage> mTopScrollTitleTabItemPages = [];
//     for (int i = 0; i < tabOrderSigns.length; i++) {
//       String tabOrderSign = tabOrderSigns[i];
//       AbsTopScrollTitleTabItemPage? page =
//           mTopScrollTitleTab.getChildPage(tabOrderSign, i);
//       if (page != null) {
//         mTopScrollTitleTabItemPages.add(page);
//       }
//     }
//
//     // TopScrollTitleTab mTopScrollTitleTab = widget;
//     // 添加监听器
//     tabController =
//         TabController(vsync: this, length: mTopScrollTitleTabItemPages.length)
//           // tabController = TabController(vsync: this, length: datas.length)
//           ..addListener(() {
//             int index = tabController.index;
//             // print('tabController.index: $index');
//             foreignVerTopTabController.changeTopBarIndex(index);
//           });
//
//     return DefaultTabController(
//         length: mTopScrollTitleTabItemPages.length,
//         // length: datas.length,
//         child: Scaffold(
//             endDrawer: mTopScrollTitleTab.endDrawer,
//             appBar: AppBar(
//               title: Center(
//                 child: Text(
//                   'App Name',
//                   style: TextStyle(color: Colors.white, fontSize: 18.0.w),
//                 ),
//               ),
//               backgroundColor: AppColors.c7635FF, elevation: 0,
//               leading: Container(),
//               actions: <Widget>[
//                 Tooltip(
//                   message: 'menu',
//                   child: Container(
//                     color: Colors.transparent,
//                     width: 80.w,
//                     child: IconButton(
//                       icon: const Icon(Icons.menu),
//                       onPressed: () {
//                         // print('menu press');
//                         if (mTopScrollTitleTab.onMenuTap != null) {
//                           mTopScrollTitleTab.onMenuTap!();
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//
//               /// 标题栏标题
//               // title: const Text('顶部导航栏'),
//               /// 设置顶部导航栏
//               bottom: TabBar(
//                 /// 可左右滑动
//                 // indicatorSize: TabBarIndicatorSize.tab,
//                 // automaticIndicatorColorAdjustment: false,
//                 controller: tabController,
//                 indicator: const BoxDecoration(),
//                 indicatorWeight: 0.0,
//                 // indicatorColor: Colors.white,
//                 isScrollable: true,
//                 labelPadding:
//                     const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
//                 padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
//                 // labelColor: AppColors.c7635FF,
//                 // labelStyle: const TextStyle(backgroundColor: Colors.white, fontSize: 14.0),
//                 // unselectedLabelColor: Colors.white,
//                 // unselectedLabelStyle: const TextStyle(backgroundColor: AppColors.c7635FF, fontSize: 14),
//                 onTap: (index) {
//                   print('top tab $index');
//                   foreignVerTopTabController.xTopIndex.value = index;
//                 },
//
//                 /// 设置顶部导航栏的图标
//                 tabs: mTopScrollTitleTabItemPages.map(
//                     (AbsTopScrollTitleTabItemPage
//                         absTopScrollTitleTabItemPage) {
//                   // tabs: datas.map((TabData data) {
//                   int curIndex = mTopScrollTitleTabItemPages
//                       .indexOf(absTopScrollTitleTabItemPage);
//                   // int curIndex = datas.indexOf(data);
//                   /// 导航栏的图标及文本
//                   return Tab(
//                       height: 26.w,
//                       child: Obx(() {
//                         TextStyle style = TextStyle(
//                           color: foreignVerTopTabController.xTopIndex.value ==
//                                   curIndex
//                               ? AppColors.c7635FF
//                               : Colors.white,
//                           fontSize: 14.w,
//                         );
//                         Size size =
//                             boundingTextSize(tabOrderTitles[curIndex], style);
//                         // Size size = boundingTextSize(data.title, style);
//                         double width = size.width + 0.5;
//                         return Container(
//                             height: 26.w,
//                             width: width + 16.w + 16.w,
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                   top: 0,
//                                   left: 0,
//                                   child: Container(
//                                       width: 16.w,
//                                       height: 26.w,
//                                       child: foreignVerTopTabController
//                                                   .xTopIndex.value ==
//                                               curIndex
//                                           ? Image.asset(R.fntopImgLeftBt,
//                                               package: 'flutter_lib_shared',
//                                               width: 16.w,
//                                               height: 26.w,
//                                               fit: BoxFit.fill)
//                                           : Container()),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   left: 16.w - 1,
//                                   child: Container(
//                                     width: width,
//                                     height: 28.w,
//                                     color: foreignVerTopTabController
//                                                 .xTopIndex.value ==
//                                             curIndex
//                                         ? Colors.white
//                                         : Colors.transparent,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   left: 16.w + width - 2,
//                                   child: Container(
//                                       width: 16.w,
//                                       height: 26.w,
//                                       child: foreignVerTopTabController
//                                                   .xTopIndex.value ==
//                                               curIndex
//                                           ? Image.asset(R.fntopImgRightBt,
//                                               package: 'flutter_lib_shared',
//                                               width: 16.w,
//                                               height: 26.w,
//                                               fit: BoxFit.fill)
//                                           : Container()),
//                                 ),
//                                 Container(
//                                     width: width + 16.w + 16.w,
//                                     height: 26.w,
//                                     child: Center(
//                                       child: Text(tabOrderTitles[curIndex],
//                                           style: style),
//                                       // child: Text(data.title, style: style),
//                                     ))
//                               ],
//                             ));
//                       })
//                       //
//                       );
//                 }).toList(),
//               ),
//             ),
//             body: TabBarView(
//                 controller: tabController,
//
//                 /// 界面显示的主体 , 通过 TabBar 切换不同的本组件显示
//                 children: mTopScrollTitleTabItemPages
//                 // children: datas.map((TabData choice) {
//                 //   return Padding(
//                 //     padding: const EdgeInsets.all(10.0),
//                 //     child: TabContent(data: choice),
//                 //   );
//                 // }).toList(),
//                 ),
//             onEndDrawerChanged: (bool isOpened) {
//               print('onEndDrawerChanged $isOpened');
//             }));
//   }
// }
//
// class TopScrollTitleTabTabItem {
//   TopScrollTitleTabTabItem(this.mTopScrollTitleTabTabItem);
//   static const TopScrollTitleTabTabItemAllGames = 'all_games';
//   static const TopScrollTitleTabTabItemOtherClassify = 'other_classify';
//   // static const TopScrollTitleTabTabItemCasual = 'casual';
//   // static const TopScrollTitleTabTabItemSports = 'sports';
//   // static const TopScrollTitleTabTabItemBoard = 'board';
//   // static const TopScrollTitleTabTabItemPuzzle = 'puzzle';
//   String mTopScrollTitleTabTabItem;
// }
//
// abstract class AbsTopScrollTitleTabItemPage extends StatelessWidget {
//   const AbsTopScrollTitleTabItemPage({
//     Key? key,
//   }) : super(key: key);
//   TopScrollTitleTabTabItem mTopScrollTitleTabTabItem();
//   void dump();
//   // String classifyTitle();
// }
