import 'package:dio/dio.dart';
import 'package:flutter_lib_shared/common/config/config.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///@author huangjianghe
///@date 2022/7/5
///网络拦截器
class NetInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var token = StorageUtil.read(Config.token);
    if (!ObjectUtil.isEmpty(token)) {
      options.headers.addAll({"Authorization": token});
    }
    var userId = StorageUtil.read(Config.userId);

    ///后台瞎搞不统一
    if (!ObjectUtil.isEmpty(userId)) {
      options.headers.addAll({"userId": userId});
      options.headers.addAll({"headUserId": userId});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    // String msg = err.requestOptions.extra["errorMsg"];
    // if (kDebugMode) {
    //   print("异常抛出:$msg");
    // }
// 异常分类 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
    switch (err.type) {
// 4xx 5xx response
      case DioErrorType.badResponse:
        err.requestOptions.extra["errorMsg"] =
            err.response?.data ?? "connection exception";
        break;
      case DioErrorType.connectionTimeout:
        err.requestOptions.extra["errorMsg"] = "connection timed out";
        break;
      case DioErrorType.sendTimeout:
        err.requestOptions.extra["errorMsg"] = "Send Timeout";
        break;
      case DioErrorType.receiveTimeout:
        err.requestOptions.extra["errorMsg"] = "receive timeout";
        break;
      case DioErrorType.cancel:
        err.requestOptions.extra["errorMsg"] =
            err.message!.isNotEmpty ? err.message : "Cancel Connection";
        break;
      case DioErrorType.unknown:
      default:
//       var connectivityResult = await (Connectivity().checkConnectivity());
// //判断是否有网络
//       if (connectivityResult == ConnectivityResult.none) {
//         err.requestOptions.extra["errorMsg"] = "网络未连接";
//         break;
//       }
        err.requestOptions.extra["errorMsg"] = "connection exception";
        break;
    }
    super.onError(err, handler);
  }
}
