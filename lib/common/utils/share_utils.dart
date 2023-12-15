import 'package:flutter/services.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/utils/common_util.dart';
import 'package:fluwx/fluwx.dart';

import '../../widgets/bottom_show_sheet.dart';

///@author huangjianghe
///@date 2022/10/26
///@description 分享工具类
class ShareUtils {
  static shareTo({
    required String shareUrl,
    required String shareTitle,
    required String description,
    String? imageUrl,
  }) {
    BottomShowSheet.bottomShareSheet(Get.context!, shareItems: [
      ShareItem.shareItemsWechat,
      ShareItem.shareItemsFriend,
      ShareItem.shareItemsQQ,
      ShareItem.shareItemsCopyLink,
    ], onPressedShareItem: (ShareItem item) {
      if (item == ShareItem.shareItemsWechat) {
        //微信分享
        shareToWeChat(WeChatShareWebPageModel(shareUrl,
                description: description,
                title: shareTitle,
                scene: WeChatScene.SESSION,
                thumbnail: ObjectUtil.isEmptyString(imageUrl)
                    ? null
                    : WeChatImage.network(imageUrl!)))
            .then((data) {
          print("-->$data");
        });
      } else if (item == ShareItem.shareItemsFriend) {
        shareToWeChat(WeChatShareWebPageModel(shareUrl,
                title: shareTitle,
                scene: WeChatScene.TIMELINE,
                thumbnail: ObjectUtil.isEmptyString(imageUrl)
                    ? null
                    : WeChatImage.network(imageUrl!)))
            .then((data) {
          print("-->$data");
        });
      } else if (item == ShareItem.shareItemsQQ) {
        // _initTencent() async {
        //   await Tencent.instance.registerApp(appId: '*******'); // 腾讯注册器
        // }
        // void _shareQq() async {
        //   final File file = await DefaultCacheManager().getSingleFile(_imagePath);
        //   print(file);
        //   await Tencent.instance.shareImage(
        //     scene: TencentScene.SCENE_QQ,
        //     imageUri: Uri.file(file.path),
        //   );
        // }
      } else if (item == ShareItem.shareItemsCopyLink) {
        Clipboard.setData(ClipboardData(text: shareUrl));
        showToast("已复制", toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }
}
