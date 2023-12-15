// /// 此文件由 python 自动生成，请勿编辑
// /// Widget的工厂类
// /// 最后生成时间: 2022-09-06 10:18:09
// // ignore_for_file: avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:flutter_lib_shared/common/base/base_list_widget.dart';
// import 'package:flutter_lib_shared/components/bottom_floating_icon_tab.dart';
// import 'package:flutter_lib_shared/components/bottom_icon_title_tab.dart';
// import 'package:flutter_lib_shared/components/card_score_template.dart';
// import 'package:flutter_lib_shared/components/icon_title_template.dart';
// import 'package:flutter_lib_shared/components/large_image_template.dart';
// import 'package:flutter_lib_shared/components/menu_list_view.dart';
// import 'package:flutter_lib_shared/components/search_view.dart';
// import 'package:flutter_lib_shared/components/side_gif_widget.dart';
// import 'package:flutter_lib_shared/components/small_image_template.dart';
// import 'package:flutter_lib_shared/components/swiper_game_card.dart';
// import 'package:flutter_lib_shared/components/swiper_view.dart';
// import 'package:flutter_lib_shared/components/top_scroll_title_tab.dart';
//
// class WidgetFactory {
//   static AbsBaseComponent? getInstanceComponent(String className, String key, Map<String, dynamic> extParams, {aspectRatioH, aspectRatioW, bannerList, barColor, changeCallBack, childWidget, endDrawer, getChildPage, image, list, menus, onItemTap, onMenuTap, onTap, outer, title, titleHint}) {
//     switch (className) {
//       case 'BottomFloatingIconTab': return BottomFloatingIconTab(key: Key(key), extParams: extParams, getChildPage: getChildPage);
//       case 'BottomIconTitleTab': return BottomIconTitleTab(key: Key(key), extParams: extParams, getChildPage: getChildPage);
//       case 'CardScoreTemplate': return CardScoreTemplate(key: Key(key), extParams: extParams, list: list, title: title, image: image, changeCallBack: changeCallBack);
//       case 'IconTitleTemplate': return IconTitleTemplate(key: Key(key), extParams: extParams, list: list, title: title, changeCallBack: changeCallBack);
//       case 'LargeImageTemplate': return LargeImageTemplate(key: Key(key), extParams: extParams, );
//       case 'MenuListView': return MenuListView(key: Key(key), extParams: extParams, menus: menus, onTap: onTap);
//       case 'SearchNavBar': return SearchNavBar(key: Key(key), extParams: extParams, titleHint: titleHint, barColor: barColor, onItemTap: onItemTap);
//       case 'SileGifWidget': return SileGifWidget(key: Key(key), extParams: extParams, childWidget: childWidget);
//       case 'SmallImageTemplate': return SmallImageTemplate(key: Key(key), extParams: extParams, list: list, title: title, image: image, changeCallBack: changeCallBack);
//       case 'SwiperGameCard': return SwiperGameCard(key: Key(key), extParams: extParams, );
//       case 'SwiperView': return SwiperView(key: Key(key), extParams: extParams, bannerList: bannerList, aspectRatioH: aspectRatioH, aspectRatioW: aspectRatioW, onItemTap: onItemTap, outer: outer);
//       case 'TopScrollTitleTab': return TopScrollTitleTab(key: Key(key), extParams: extParams, getChildPage: getChildPage, onMenuTap: onMenuTap, endDrawer: endDrawer);
//       default:
//         break;
//     }
//     print(' factory null Widget $className');
//     return null;
//   }
// }
