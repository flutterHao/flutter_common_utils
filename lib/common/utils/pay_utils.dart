import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/utils/common_util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:tobias/tobias.dart' as tobias;
import 'package:tobias/tobias.dart';

import '../../widgets/bottom_show_sheet.dart';

///@author Hao
///@date 2022/10/26
///@description 支付工具类
class PayUtils {
  ///微信支付
  static Future<bool> weChatPay({
    required String appId,
    required String partnerId,
    required String prepayId,
    required String packageValue,
    required String nonceStr,
    required int timeStamp,
    required String sign,
    String? signType,
    String? extData,
  }) async {
    if (!await fluwx.isWeChatInstalled) {
      showToast('请安装微信');
      return false;
    }

    return fluwx.payWithWeChat(
        appId: appId,
        partnerId: partnerId,
        prepayId: prepayId,
        packageValue: packageValue,
        nonceStr: nonceStr,
        timeStamp: timeStamp,
        sign: sign);
    // fluwx.launchWeChatMiniProgram(username: username)
  }

  static payTo(List<Map<String, String>> shareItems,
      Function(int selectedIndex) onPressedItem) {
    BottomShowSheet.bottomPaySheet(Get.context!,
        shareItems: shareItems, onPressedItem: onPressedItem);
  }

  ///支付宝支付
  static Future<bool> aliPay(String orderId) async {
    if (!await tobias.isAliPayInstalled()) {
      showToast('请安装支付宝');
      return false;
    }
    // String orderIds = "alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2021000119634069&biz_content=%7B%22out_trade_no%22%3A%2270501111111S001111119%22%2C%22total_amount%22%3A%229.00%22%2C%22subject%22%3A%22%E5%A4%A7%E4%B9%90%E9%80%8F%22%7D&charset=UTF8&format=json&method=alipay.trade.app.pay&sign=GfO2bwTjot7sPedU1l5ZDspQ0tZWcQ7LI2GyD7r1Mlu%2FK3Sc%2BIu3v4FyASExssH9mosz7xhngkcXO4ZOPD9EE67c05mFwizEvle2OJG78GlwHZjw1C%2FeS5rS%2BCk%2B0qwFVXifkLA5xZzSn8tvvvEoFE5%2FNg%2BCCHLIaCV30OnMMomc9R4nrTivJrHWL%2FlZDj67Ov1ycmmSlBI%2FB%2Blklmt6czz%2BJywg5%2BxgSqBsXWTPztpAyirpfT%2BUTYR4qJz4wMB3UL4dfjFl4Ka7jReadV5dN1S6RMfGw8bmTgUBt8JJewp8iXCYxga9eBKfrX%2B8CqFn4tpr9zHP%2F1PxgD%2FRyYyi2Q%3D%3D&sign_type=RSA2&timestamp=2023-02-21+16%3A15%3A36";
    Map map = await tobias.aliPay(
      orderId,
    );
    //支付完成返回费用查缴页面
    logD("支付宝返回参数：$map");
    String respMsg = map['memo'];
    int resultStatus = int.parse(map['resultStatus'] ?? '0');
    bool isPaySuccess = false;
    if (resultStatus == 9000) {
      // showToast('订单支付成功');
      isPaySuccess = true;
    } else {
      isPaySuccess = false;
      // if (resultStatus == 8000) {
      //   respMsg = '正在处理中';
      // } else if (resultStatus == 6001) {
      //   respMsg = '用户中途取消';
      // } else if (resultStatus == 6002) {
      //   respMsg = '网络连接出错';
      // } else if (resultStatus == 4000) {
      //   respMsg = '订单支付失败';
      // }
      // showToast(respMsg);
    }
    return isPaySuccess;
  }

  ///获取微信授权码
  static weChatAuthorize(Function getWeChatCode) {
    fluwx.sendWeChatAuth(scope: "snsapi_userinfo");
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatAuthResponse) {
        if (res.errCode == 0) {
          getWeChatCode(res.code);
          // showToast("微信返回的授权码=======${res.code}");
          // logD("微信返回的授权码=======${res.code}");
        }
      }
    });
  }
}
