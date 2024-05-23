import 'package:dio/dio.dart';

import '../utils/log_util.dart';

///@author Hao
///@date 2022/7/21
///@description 处理异常
class ApiException implements Exception {
  static const unknownException = 'unknown error';

  final String? message;
  final int? code;
  ApiException([this.code, this.message]);
  factory ApiException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(-1, "Request Cancel");
      case DioErrorType.connectionTimeout:
        return BadRequestException(-1, "connection timed out");
      case DioErrorType.sendTimeout:
        return BadRequestException(-1, "request timeout");
      case DioErrorType.receiveTimeout:
        return BadRequestException(-1, "Response timeout");
      case DioErrorType.badResponse:
        try {
          /// http 错误码带业务错误信息
          // ApiResponse apiResponse = ApiResponse.fromJson(error.response?.data);
          // if (apiResponse.code != null) {
          //   return ApiException(apiResponse.code, apiResponse.message);
          // }
          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, "Bad Request");
            case 401:
              return UnauthorisedException(errCode!, "Unauthorized");
            case 403:
              return UnauthorisedException(errCode!, "Forbidden");
            case 404:
              return UnauthorisedException(errCode!, "Not Found");
            case 405:
              return UnauthorisedException(errCode!, "Method Not Allowed");
            case 500:
              return UnauthorisedException(errCode!, "Internal Server Error");
            case 502:
              return UnauthorisedException(errCode!, "Bad Gateway");
            case 503:
              return UnauthorisedException(errCode!, "Service Unavailable");
            case 505:
              return UnauthorisedException(
                  errCode!, "HTTP Version Not Supported");
            default:
              return ApiException(errCode,
                  error.response?.statusMessage ?? 'The network is busy');
          }
        } on Exception {
          return ApiException(-1, unknownException);
        }
      default:
        return ApiException(-1, error.message);
    }
  }
  factory ApiException.from(dynamic exception) {
    if (exception is DioError) {
      logE("DioError：$exception");
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      logE("ApiException：${exception.message}");
      return exception;
    } else {
      var apiException = ApiException(-1, unknownException);
      // apiException.stackInfo = exception?.toString();
      logE("ApiException：$exception");

      return apiException;
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int code = -1, String message = ''])
      : super(code, message);
}
