import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///改文件不要随便改
class Config {
  static const String token = "token";
  static const String userId = "userId";

  ///组件所需要的配置字段
  static Map fieldMap = {
    ///轮播模板字段
    ConstantComponent.cSwiperView: [
      ConstantComponent.id, // 	ID	integer(int64)
      "gameId",
      "subject", // subject	主题
      ConstantComponent.url, //图片/视频	string
      "leadTo", // 	跳转项	string
      "externalLinkUrl", // 	外部链接URL	string
    ],

    ///大图模板字段
    ConstantComponent.cLargeImageTemplate: [
      ConstantComponent.id,
      ConstantComponent.name, // 游戏名称	string
      ConstantComponent.url, //图片
      "score", //分数
      "desc",
    ],

    ///小图模板字段
    ConstantComponent.cSmallImageTemplate: [
      ConstantComponent.id, // ID	integer(int32)
      ConstantComponent.name, //  名称	string
      ConstantComponent.url, //图片
      "playNum", //在玩人数
    ],

    ///卡片模板字段
    ConstantComponent.cCardScoreTemplate: [
      ConstantComponent.id, //游戏ID	integer(int32)
      ConstantComponent.name, // 游戏名称	string
      'introduction', // introduction	一句话简介	string
      ConstantComponent.url, // 图标 string
      "score" // 评分 number(double)
    ],

    ///图标模板字段
    ConstantComponent.cIconTitleTemplate: [
      ConstantComponent.id, //游戏ID	integer(int32)
      ConstantComponent.name, //  名称	string
      ConstantComponent.url, // 图标 string
    ],

    ///分类模板
    ConstantComponent.cMenuListView: [
      ConstantComponent.id, //游戏ID	integer(int32)
      ConstantComponent.name, // 游戏名称	string
      ConstantComponent.url // 图标 string
    ],
  };
}
