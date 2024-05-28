import 'package:dio/dio.dart';
import 'package:flutter_lib_shared/common/utils/data_util.dart';

///@author lihonghao
///@date 2022/7/6
///日志拦截器
class LogsInterceptor extends LogInterceptor {
  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  void Function(Object object) logPrint;

  LogsInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  }) : super(
            request: request,
            requestHeader: requestHeader,
            requestBody: requestBody,
            responseHeader: requestHeader,
            responseBody: responseBody);

  @override
  Future onRequest(RequestOptions options, handler) async {
    // if (kDebugMode) {
    //   print("请求url：${options.path} ${options.method}");
    //   options.headers.forEach((k, v) => options.headers[k] = v ?? "");
    //   print('请求头: ${options.headers}');
    //   if (options.data != null) {
    //     print('请求参数: ${options.data}');
    //   }
    //
    // }

    logPrint('\n==================== REQUEST ====================\n');
    _printKV('uri', options.uri);
    //options.headers;

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType.toString());
      _printKV('followRedirects', options.followRedirects);
      _printKV('connectTimeout', options.connectTimeout);
      _printKV('sendTimeout', options.sendTimeout);
      _printKV('receiveTimeout', options.receiveTimeout);
      _printKV(
          'receiveDataWhenStatusError', options.receiveDataWhenStatusError);
      _printKV('extra', options.extra);
    }
    if (requestHeader) {
      logPrint('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      logPrint('data:');
      _printAll(options.data);
    }
    logPrint('');
    handler.next(options);
  }

  void _printKV(String key, Object? v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
  // @override
  // Future onError(DioError err, ErrorInterceptorHandler handler) async {
  //   String errorStr = "\n==================== RESPONSE ====================\n"
  //       "- URL:\n${err.requestOptions.baseUrl + err.requestOptions.path}\n"
  //       "- METHOD: ${err.requestOptions.method}\n";
  //
  //   errorStr +=
  //       "- HEADER:\n${err.response?.requestOptions.headers.mapToStructureString()}\n";
  //   if (err.response != null && err.response?.data != null) {
  //     if (kDebugMode) {
  //       print('╔ ${err.type.toString()}');
  //     }
  //     errorStr += "- ERROR:\n${_parseResponse(err.response)}\n";
  //   } else {
  //     errorStr += "- ERRORTYPE: ${err.type}\n";
  //     errorStr += "- MSG: ${err.message}\n";
  //   }
  //   if (kDebugMode) {
  //     print(errorStr);
  //   }
  //   return err;
  // }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (responseBody) {
      String responseStr =
          "\n==================== RESPONSE ====================\n"
          "- URL:\n${response.requestOptions.uri}\n";
      responseStr += "- HEADER:\n{";
      response.headers.forEach(
          (key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
      responseStr += "\n}\n";
      responseStr += "- STATUS: ${response.statusCode}\n";

      if (response.data != null) {
        responseStr += "- BODY:\n ${_parseResponse(response)}";
      }
      printWrapped(responseStr);
    }

    handler.next(response);
  }
}

String _parseResponse(Response? response) {
  String responseStr = "";
  if (response == null) {
    return responseStr;
  }
  var data = response.data;
  if (data is Map) {
    responseStr += data.mapToStructureString();
  } else if (data is List) {
    responseStr += data.listToStructureString();
  } else {
    responseStr += response.data.toString();
  }
  return responseStr;
}
