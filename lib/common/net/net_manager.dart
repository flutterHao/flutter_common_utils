import 'dart:io';
import 'dart:typed_data';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lib_shared/common/net/abs_parser.dart';
import 'package:flutter_lib_shared/common/utils/common_util.dart';

import 'api_exception.dart';
import 'interceptors/logs_interceptor.dart';
import 'interceptors/net_interceptor.dart';

///@author huangjianghe
///@date 2022/7/4
///@description 网络请求

//TODO 网络缓存、文件上传/下载

enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

final NetManager netManager = NetManager();

class NetManager {
  //全局单例的网络访问
  static final NetManager _instance = NetManager._internal();

  NetManager._internal();

  static NetManager getInstance() => _instance;

  //工厂构造函数
  factory NetManager() => _instance;

  static const int _defaultConnectTimeout = 30 * 1000;
  static const int _defaultReceiveTimeout = 30 * 1000;

  //代理服务器Ip
  // String proxyIp = '1';
  late Dio _dio;
  late String _baseUrl;
  int? _connectTimeout;
  int? _receiveTimeout;
  Map<String, dynamic>? _headers;
  List<Interceptor>? _interceptors;

  ///设置开启代理
  bool _enableProxy = false;

  ///代理地址
  String? _proxyAddress;

  late AbsParser _parser;

  bool _enableLog = true;

  // MultiPartFileConverter _converter;
  NetManager setUrl(String url) {
    _baseUrl = url;
    return this;
  }

  NetManager setParser(AbsParser parser) {
    _parser = parser;
    return this;
  }

  ///设置连接超时时长
  NetManager setConnectTimeout(int milliseconds) {
    _connectTimeout = milliseconds;
    return this;
  }

  ///设置接收超时时长
  NetManager setReceiveTimeout(int milliseconds) {
    _receiveTimeout = milliseconds;
    return this;
  }

  ///设置Header
  NetManager setHeaders(Map<String, dynamic> headersMap) {
    _headers = headersMap;
    return this;
  }

  ///添加拦截器
  NetManager addInterceptor(List<Interceptor> interceptors) {
    _interceptors = interceptors;
    return this;
  }

  NetManager setEnableLog(bool enableLog) {
    _enableLog = enableLog;
    return this;
  }

  ///设置代理
  NetManager setProxy({bool? enable, String? ip, int? port}) {
    _enableProxy = enable!;
    _proxyAddress = "$ip:$port";
    return this;
  }

  ///添设置MultiPartFile转换器
  // NetBuilder setMultiPartFileConverter(MultiPartFileConverter converter) {
  //   _converter = converter;
  //   return this;
  // }

  ///设置http代理(设置即开启)
  void _setHttpProxy() {
    if (_enableProxy) {
      _dio.httpClientAdapter = IOHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          // if (Platform.isIOS && !Tool.Utils.productReleaseEnv() && Constant.isHasProxy) {
          //
          // }
          client.findProxy = (url) => "PROXY $_proxyAddress";
          client.badCertificateCallback = (arg1, arg2, arg3) => true;
          return null;
        };
    }
  }

  /// 设置https证书校验
  void _setHttpsCertificateVerification({String? pem, bool enable = false}) {
    if (enable) {
      _dio.httpClientAdapter = IOHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cet, String host, int port) {
            if (cet.pem == pem) {
              return true;
            }
            return false;
          };
          return null;
        };
    }
  }

  ///构建
  build() {
    _dio = Dio();
    var options = BaseOptions(
      headers: {
        // "Content-Type": "application/x-www-form-urlencoded",
        // "Content-Type": "application/json;charset=utf-8",
        "Accept": "*/*",
        // "Access-Control-Allow-Origin": "*",
        // 'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE' ,// If needed
        // 'Access-Control-Allow-Headers': 'X-Requested-With,content-type', // If needed
        // 'Access-Control-Allow-Credentials': true // If  needed
        // "Authorization": UserManager.getInstance().accessToken
      },
      responseType: ResponseType.json,
      // contentType: Headers.jsonContentType,
    );
    if (!ObjectUtil.isEmptyMap(_headers)) {
      options.headers.addAll(_headers!);
    }
    options.connectTimeout =
        Duration(milliseconds: _connectTimeout ?? _defaultConnectTimeout);
    options.receiveTimeout =
        Duration(milliseconds: _receiveTimeout ?? _defaultReceiveTimeout);
    options.baseUrl = _baseUrl;
    _dio.options = options;

    _dio.interceptors.add(NetInterceptor());
    if (!ObjectUtil.isEmptyList(_interceptors)) {
      _dio.interceptors.addAll(_interceptors!);
    }
    if (_enableLog) {
      _dio.interceptors.add(LogsInterceptor(
        requestBody: kDebugMode,
        responseBody: kIsWeb ? false : kDebugMode,
      ));
    }

    _setHttpProxy();
  }

  // var _subscription;
  //
  // bool isConnected = true;
  //
  // void listenerNet() {
  //   _subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.none) {
  //       isConnected = false;
  //     } else {
  //       isConnected = true;
  //     }
  //   });
  // }

  request<T>(String path,
      {DioMethod method = DioMethod.get,
      dynamic params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParams,
      bool isWithLoading = false,
      required Function onSuccess,
      Function? onError,
      String? tips = "LOADING"}) async {
    if (isWithLoading) {
      EasyLoading.show(status: tips);
    }
    if (await checkNetState()) {
      showToast("No network, please check the network connection settings");
      return;
    }
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    Response response;
    options ??= Options(method: _methodValues[method]);

    try {
      response = await _dio.request(path,
          data: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParams);
      if (isWithLoading) {
        EasyLoading.dismiss();
      }
      onSuccess(_parser.parse<T>(response));
      // return _parser.parse<T>(response);
    } catch (e) {
      ApiException apiException = ApiException.from(e);
      EasyLoading.showToast(apiException.message ??
          'The network is busy, please try again later!');
      // logD("异常：$e");
      if (isWithLoading) {
        EasyLoading.dismiss();
      }
      if (onError != null) {
        onError(apiException);
      }
    }
  }

  get<T>(String path,
          {Map<String, dynamic>? params,
          Options? options,
          CancelToken? cancelToken,
          ProgressCallback? onReceiveProgress,
          bool isWithLoading = false,
          Map<String, dynamic>? queryParams,
          required Function onSuccess,
          Function? onError,
          String? tips}) =>
      request<T>(path,
          params: params,
          options: options,
          cancelToken: cancelToken,
          method: DioMethod.get,
          queryParams: queryParams,
          onReceiveProgress: onReceiveProgress,
          isWithLoading: isWithLoading,
          onSuccess: onSuccess,
          onError: onError,
          tips: tips);

  post<T>(String path,
          {dynamic params,
          Options? options,
          CancelToken? cancelToken,
          ProgressCallback? onReceiveProgress,
          Map<String, dynamic>? queryParams,
          bool isWithLoading = false,
          required Function onSuccess,
          Function? onError,
          String? tips}) =>
      request<T>(path,
          params: params,
          options: options,
          cancelToken: cancelToken,
          method: DioMethod.post,
          queryParams: queryParams,
          onReceiveProgress: onReceiveProgress,
          isWithLoading: isWithLoading,
          onSuccess: onSuccess,
          onError: onError,
          tips: tips);

  Future<Response<Uint8List?>> download(dynamic url, params,
      {String method = "post"}) async {
    Response<Uint8List?> response = await _dio.request<Uint8List>(url,
        data: params,
        options: Options(
          method: method,
          responseType: ResponseType.bytes,
        ));
    return response;
  }
}
