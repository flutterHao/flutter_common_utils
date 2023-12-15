// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/exports/web_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:package_info_plus/package_info_plus.dart';

///author:lihonghao
///discript:应用更新
///date:2022/10/20
class AppUpdate {
  static init() async {
    await initXUpdate();
    await initPackageInfo();
  }

  ///app更新初始化
  static Future initXUpdate() async {
    if (Platform.isAndroid) {
      await FlutterXUpdate.init(

              ///是否输出日志
              debug: true,

              ///是否使用post请求
              isPost: false,

              ///post请求是否是上传json
              isPostJson: false,

              ///请求响应超时时间
              timeout: 25000,

              ///是否开启自动模式
              isWifiOnly: false,

              ///是否开启自动模式
              isAutoMode: false,

              ///需要设置的公共参数
              supportSilentInstall: false,

              ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
              enableRetry: false)
          .then((value) {})
          .catchError((error) {
        // logD(error);
      });

      FlutterXUpdate.setErrorHandler(
          onUpdateError: (Map<String, dynamic>? message) async {
        if (ObjectUtil.isNotEmpty(message)) {
          String msg = jsonEncode(message);
          logD(msg);
        }
      });
    }
  }

  ///当前版本
  static late String version;
  static late int versionCode;
  //更新内容
  static late UpdateEntity updateEntity;

  ///获取App版本信息
  static Future initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    versionCode = int.parse(packageInfo.buildNumber);
  }

  ///Android弹窗提示及更新
  static Future updateVersion(context,
      {String img = "upgrade_popup",
      String themeColor = "#FFAC6BFF",
      String buttonTextColor = '#FFFFFFFF'}) async {
    if (updateEntity.hasUpdate ?? false) {
      if (Platform.isAndroid) {
        FlutterXUpdate.updateByInfo(
            widthRatio: 320 / 360,
            updateEntity: updateEntity,
            topImageRes: img,
            themeColor: themeColor,
            buttonTextColor: buttonTextColor);
      } else if (Platform.isIOS) {
        await appUpdateDialog(context);
      }
    }
  }

  //更新弹窗
  static Future appUpdateDialog(BuildContext context) {
    // GameData data = GameData();
    // data.packageName = "qqq";
    // data.apkUrl = AppUpdate.updateEntity.downloadUrl!;
    // data.gameId = 1;
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 320.w,
                height: 400.w,
                decoration: BoxDecoration(borderRadius: 12.br),
                child: Column(
                  children: [
                    Image.asset(
                      width: 320.w,
                      R.imgUpgradePopup,
                      package: 'flutter_lib_shared',
                      fit: BoxFit.fitWidth,
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top:
                                    BorderSide(width: 0, color: Colors.white))),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 10.0),
                              child: Text("检查到新版本", style: 16.w4()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(
                                  'V ${AppUpdate.updateEntity.versionName!}',
                                  style: 14.w4(color: Colors.black54)),
                            ),
                            Expanded(
                              child: Text(
                                AppUpdate.updateEntity.updateContent!,
                                style: 14.w4(color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Obx(() {
                            //   return Text(data.percent.value.toString());
                            // }),
                            Container(
                              height: 48,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: AppColors.cF0F0F0))),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Center(
                                            child: Text(
                                          "残忍拒绝",
                                          style:
                                              16.w4(color: AppColors.c666666),
                                        ))),
                                  ),
                                  Container(
                                    height: 88,
                                    width: 1,
                                    color: AppColors.cF0F0F0,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            if (Platform.isAndroid) {
                                              launchUrl(Uri.parse(AppUpdate
                                                  .updateEntity.downloadUrl!));
                                              // if (data.downloadState.value == 4) {
                                              //   // FlutterVaPlugin.launchApp(
                                              //   //     data.packageName, Global.uid);
                                              //   // OpenFile.open(data.filePath);
                                              //   return;
                                              // }
                                              // Utils.appUpdate(data);
                                            } else {
                                              launchUrl(Uri.parse(
                                                  'https://www.apple.com/app-store/'));
                                            }
                                          },
                                          child: Center(
                                              child: Text(
                                            "立即更新",
                                            style: 16.w4(
                                                color: AppColors.primaryColor),
                                          )))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
