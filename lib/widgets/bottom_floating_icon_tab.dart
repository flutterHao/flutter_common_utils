// import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
// import 'package:flutter_lib_shared/common/exports/common_lib.dart';
// import '../generated/r.dart';
//
// class BottomFloatingIconTab extends AbsBaseComponent {
//   BottomFloatingIconTab({
//     Key? key,
//     required Map<String, dynamic> extParams,
//     required this.getChildPage,
//   }) : super(key: key, extParams: extParams);
//
//   final AbsBottomFloatingIconTabItemPage Function(String sign, int index)
//       getChildPage;
//
//   static Color tabFontColorNormal = AppColors.c999999;
//   static Color tabFontColorSelected = const Color(0xFF8627FF);
//
//   // static String assetsImage = 'assets/images/';
//
//   @override
//   void dump() {}
//
//   @override
//   WidgetInfos widgetInfos() {
//     return WidgetInfos(
//         name: '国外底部tab',
//         description: '组件描述',
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
//   Map<String, ExtParamInfos> privateExtParams() {
//     return {
//       'tab_order_signs': ExtParamInfos(
//           name: 'tab顺序标记',
//           description: 'tab顺序标记',
//           dataType: ExtParamInfos.dataTypeListString,
//           defaultValue: 'wallet_page,home_page,referral_page',
//           paramVersion: '1.0.1')
//     };
//   }
//
//   @override
//   Map<String, EventInfos> privateDatasourceEvents() {
//     return {
//       'event_sing': EventInfos(extParamInfos: {
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
//   final mBottomFloatingIconTabController = BottomFloatingIconTabController();
//
//   Container createItem(
//       Widget icon, Color color, String tabName, Function() onPressed) {
//     return Container(
//       width: 100.w,
//       height: 71.w,
//       color: Colors.transparent,
//       child: Stack(
//         children: [
//           Container(
//             width: 100.w,
//             height: 42.w,
//             color: Colors.transparent,
//             child: IconButton(
//               padding: const EdgeInsets.all(0),
//               icon: icon, // const Icon(Icons.search),
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               color:
//                   color, // BottomFloatingIconTabController.xBottombarIndex.value == 0 ? AppColors.c892CFF:AppColors.cC0C0C0,
//               onPressed: () {
//                 // BottomFloatingIconTabController.xBottombarIndex.value = 0;
//                 onPressed();
//               },
//             ),
//           ),
//           Positioned(
//             top: 30.w,
//             child: Container(
//               width: 100.w,
//               // height: 25,
//               color: Colors.transparent,
//               // padding: const EdgeInsets.only(bottom: 10.0),
//               child: TextButton(
//                 onPressed: () {
//                   // BottomFloatingIconTabController.xBottombarIndex.value = 0;
//                   onPressed();
//                 },
//                 style: ButtonStyle(
//                   overlayColor: MaterialStateProperty.all(Colors.transparent),
//                   foregroundColor: MaterialStateProperty.resolveWith((states) {
//                     return states.contains(MaterialState.pressed)
//                         ? Colors.transparent
//                         : Colors.transparent;
//                   }),
//                   backgroundColor: MaterialStateProperty.resolveWith((states) {
//                     return states.contains(MaterialState.pressed)
//                         ? Colors.transparent
//                         : Colors.transparent;
//                   }),
//                 ),
//                 child: Text(tabName,
//                     style: TextStyle(
//                       fontSize: 14.0.w,
//                       color:
//                           color, // BottomFloatingIconTabController.xBottombarIndex.value == 0 ? AppColors.c892CFF :AppColors.cC0C0C0,
//                     )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     BottomFloatingIconTab mBottomFloatingIconTab =
//         context.widget as BottomFloatingIconTab;
//     Map<String, dynamic> extParams = mBottomFloatingIconTab.extParams;
//     String tabOrderSignsStr = extParams['tab_order_signs'] ?? '';
//     List<String> tabOrderSigns = tabOrderSignsStr.split(',');
//     List<Widget> pages = [];
//     for (int i = 0; i < tabOrderSigns.length; i++) {
//       String tabOrderSign = tabOrderSigns[i];
//       pages.add(mBottomFloatingIconTab.getChildPage(tabOrderSign, i));
//     }
//     // List<Widget> BottomFloatingIconTabItemPages = []; // BottomFloatingIconTab.baseTabItemPages;
//     // if (BottomFloatingIconTab.BottomFloatingIconTabItemWalletPage != null) {
//     //   BottomFloatingIconTabItemPages.add(BottomFloatingIconTab.BottomFloatingIconTabItemWalletPage);
//     // }
//     // if (BottomFloatingIconTab.BottomFloatingIconTabItemHomePage != null) {
//     //   BottomFloatingIconTabItemPages.add(BottomFloatingIconTab.BottomFloatingIconTabItemHomePage);
//     // }
//     // if (BottomFloatingIconTab.BottomFloatingIconTabItemReferralPage != null) {
//     //   BottomFloatingIconTabItemPages.add(BottomFloatingIconTab.BottomFloatingIconTabItemReferralPage);
//     // }
//
//     print('--------------- tab BottomFloatingIconTab build');
//     // List<Widget> pages = BottomFloatingIconTab.BottomFloatingIconTabItemPages;
//     // int counter = 0;
//     // List<BottomNavigationBarItem> items = pages.map((page) {
//     //         print('===== create items');
//     //         print(BottomFloatingIconTab.optionalPages());
//     //         TabItemInfo? tabItemInfo = BottomFloatingIconTab.optionalPages()[page.BottomFloatingIconTabItem().BottomFloatingIconTabItem];
//     //         print(tabItemInfo);
//     //         double sizeWidth = 24.0;
//     //         BottomNavigationBarItem item = BottomNavigationBarItem(
//     //           icon: tabItemInfo!.tabIconNormal.isNotEmpty ? Image.asset(tabItemInfo.tabIconNormal, width: sizeWidth, height: sizeWidth, package: 'flutter_lib_shared') : Container(),
//     //           activeIcon: tabItemInfo.tabIconSelected.isNotEmpty ? Image.asset(tabItemInfo.tabIconSelected, width: sizeWidth, height: sizeWidth, package: 'flutter_lib_shared') : Container(),
//     //           label: tabItemInfo.defaultTabName,
//     //           tooltip: '');
//     //           // counter++;
//     //         return item;
//     //       }).toList();
//     return Scaffold(
//       // appBar: appBar,
//       // backgroundColor: Colors.purpleAccent,
//       body: Obx(() {
//         return IndexedStack(
//           index: mBottomFloatingIconTabController.xBottombarIndex.value,
//           children: pages,
//         );
//       }),
//
//       floatingActionButton: Obx(() {
//         return Container(
//           // color: Colors.yellow.withOpacity(0.5),
//           color: Colors.transparent,
//           // width: 56.w + 12.w * 2,
//           width: 70.w,
//           // height: 140.w,
//           height: 56.w + 12.w * 2,
//           margin: EdgeInsets.only(top: (56.w + 12.w * 2) - 21.w * 2 ),
//           // margin: EdgeInsets.only(top: (56.w)),
//           child: Stack(
//             children: [
//               // ImageUtil.asset(R.fnbomtabImgSemicircle, width: 70.w, height: 21.w),
//               Container(
//                 margin: EdgeInsets.only(top: 2.w),
//                 child: Image.asset(R.fnbomtabImgSemicircle, width: 70.w, height: 21.w, package: 'flutter_lib_shared',),
//               ),
//               // ImageUtil.asset(R.fnbomtabLogo, width: 70.w, height: 21.w,),
//               Column(
//                 children: [
//                   Container(
//                     width: 56.w,
//                     height: 12.w, // (56.w + 12.w * 2) * 0.5 - 21.w,
//                     // height: (71 * 2 - 56).w * 0.5,
//                     color: Colors.transparent,
//                   ),
//                   Container(
//                     width: 56.w,
//                     height: 56.w,
//                     margin: EdgeInsets.only(left: 0.5 * (71.w - 56.w)),
//                     color: Colors.transparent,
//                     child: IconButton(
//                       padding: const EdgeInsets.all(0),
//                       icon:
//                           ImageUtil.asset(R.fnbomtabLogo, width: 56.0.w, height: 56.0.w),
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       color: mBottomFloatingIconTabController
//                                   .xBottombarIndex.value ==
//                               1
//                           ? AppColors.c892CFF
//                           : AppColors.cC0C0C0,
//                       onPressed: () {
//                         mBottomFloatingIconTabController.xBottombarIndex.value =
//                             1;
//                         // onPressed();
//                       },
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         );
//       }),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: Obx((() {
//         return BottomAppBar(
//             color: Colors.transparent,
//             elevation: 0.0,
//             notchMargin: 0.0,
//             shape: const CircularNotchedRectangle(),
//             child: Container(
//                 color: Colors.transparent,
//                 // color: Colors.pink.withOpacity(0.3),
//                 width: 360.w,
//                 // height: 92.w,
//                 height: 71.w,
//                 child: Stack(
//                   children: [
//                     // Positioned(
//                     //   left: 0,
//                     //   top: 0,
//                     //   width: 360.w,
//                     //   height: 92.w,
//                     //   child: ImageUtil.asset(R.fnbomtabImgBg, width: 360.w, height: 92.w),
//                     // ),
//                     Container(
//                       width: (MediaQuery.of(context).size.width - 70.w) * 0.5 + 2.w,
//                       height: 2.w,
//                       color: const Color(0xFFEFE8F6),
//                       // decoration: BoxDecoration(
//                       //   gradient: LinearGradient(
//                       //     begin: Alignment.topCenter,
//                       //     end: Alignment.bottomCenter,
//                       //     colors: [
//                       //       // Color(0xFFAEB6FF),
//                       //       Color(0xFFEFE8F6).withOpacity(1),
//                       //       Color(0xFFEFE8F6).withOpacity(1),
//                       //     ]
//                       //   ),
//                       // ),
//                     ),
//                     Container(
//                       width: (MediaQuery.of(context).size.width - 70.w) * 0.5 + 2.w,
//                       height: 2.w,
//                       margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 70.w) * 0.5 + 70.w - 2.w),
//                       color: const Color(0xFFEFE8F6),
//                       // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 70.w) * 0.5)),
//                       // decoration: BoxDecoration(
//                       //   gradient: LinearGradient(
//                       //     begin: Alignment.topCenter,
//                       //     end: Alignment.bottomCenter,
//                       //     colors: [
//                       //       // Color(0xFFAEB6FF),
//                       //       Color(0xFFEFE8F6),
//                       //       Color(0xFFEFE8F6),
//                       //     ]
//                       //   ),
//                       // ),
//                     ),
//                     Positioned(
//                       left: 30.w,
//                       top: 0.w,
//                       child: createItem(
//                           ImageUtil.asset(
//                             mBottomFloatingIconTabController
//                                         .xBottombarIndex.value ==
//                                     0
//                                 ? R.fnbomtabIconWalletClicked
//                                 : R.fnbomtabIconWalletNotClicked,
//                             width: 42.0.w,
//                             height: 42.0.w,
//                           ),
//                           mBottomFloatingIconTabController
//                                       .xBottombarIndex.value ==
//                                   0
//                               ? AppColors.c892CFF
//                               : AppColors.cC0C0C0,
//                           'Wallet', () {
//                         mBottomFloatingIconTabController.xBottombarIndex.value =
//                             0;
//                       }),
//                     ),
//                     Positioned(
//                       right: 30.w,
//                       top: 0.w,
//                       child: createItem(
//                           ImageUtil.asset(
//                             mBottomFloatingIconTabController
//                                         .xBottombarIndex.value ==
//                                     2
//                                 ? R.fnbomtabIconReferralClicked
//                                 : R.fnbomtabIconReferralNotClicked,
//                             width: 42.0.w,
//                             height: 42.0.w,
//                           ),
//                           mBottomFloatingIconTabController
//                                       .xBottombarIndex.value ==
//                                   2
//                               ? AppColors.c892CFF
//                               : AppColors.cC0C0C0,
//                           'Referral', () {
//                         mBottomFloatingIconTabController.xBottombarIndex.value =
//                             2;
//                       }),
//                     ),
//                   ],
//                 )));
//       })),
//     );
//   }
// }
//
// // class _BottomFloatingIconTabState extends State<BottomFloatingIconTab> {
// //   // int _bottombar_index = 0;
//
// // }
//
// class BottomFloatingIconTabController extends GetxController {
//   RxInt xBottombarIndex = 1.obs;
//   changeBottomBarIndex(int index) {
//     xBottombarIndex.value = index;
//     print(xBottombarIndex.value);
//   }
// }
//
// class BottomFloatingIconTabItem {
//   BottomFloatingIconTabItem(this.mBottomFloatingIconTabItem);
//   static const mBottomFloatingIconTabItemHomePage = 'home_page';
//   static const mBottomFloatingIconTabItemWalletPage = 'wallet_page';
//   static const mBottomFloatingIconTabItemReferralPage = 'referral_page';
//   String mBottomFloatingIconTabItem;
// }
//
// abstract class AbsBottomFloatingIconTabItemPage extends StatelessWidget {
//   const AbsBottomFloatingIconTabItemPage({Key? key}) : super(key: key);
//   void dump();
//   BottomFloatingIconTabItem mBottomFloatingIconTabItem();
// }
//
// // abstract class BottomFloatingIconTabItemHomePage extends BottomFloatingIconTabItemPage {
// //   const BottomFloatingIconTabItemHomePage({Key? key,}) : super(key: key);
// //   @override
// //   BottomFloatingIconTabItem BottomFloatingIconTabItem() {
// //     return BottomFloatingIconTabItem(BottomFloatingIconTabItem.BottomFloatingIconTabItemHomePage);
// //   }
// // }
//
// // abstract class BottomFloatingIconTabItemWalletPage extends BottomFloatingIconTabItemPage {
// //   const BottomFloatingIconTabItemWalletPage({Key? key,}) : super(key: key);
// //   @override
// //   BottomFloatingIconTabItem BottomFloatingIconTabItem() {
// //     return BottomFloatingIconTabItem(BottomFloatingIconTabItem.BottomFloatingIconTabItemWalletPage);
// //   }
// // }
//
// // abstract class BottomFloatingIconTabItemReferralPage extends BottomFloatingIconTabItemPage {
// //   const BottomFloatingIconTabItemReferralPage({Key? key,}) : super(key: key);
// //   @override
// //   BottomFloatingIconTabItem BottomFloatingIconTabItem() {
// //     return BottomFloatingIconTabItem(BottomFloatingIconTabItem.BottomFloatingIconTabItemReferralPage);
// //   }
// // }
//
// class ForeignVerTopTabController extends GetxController {
//   RxInt xTopIndex = 0.obs;
//   changeTopBarIndex(int index) {
//     xTopIndex.value = index;
//     print('foreign top tab $index');
//   }
// }
