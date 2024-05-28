import 'package:logger/logger.dart';

///@author lihonghao
///@date 2022/7/26
///@description 日志打印
var _logger = Logger();

logV(String msg, {String tag = "TAG"}) {
  _logger.v("$tag :: $msg");
}

logD(String msg, {String tag = "TAG"}) {
  _logger.d("$tag :: $msg");
}

logI(String msg, {String tag = "TAG"}) {
  _logger.i("$tag :: $msg");
}

logW(String msg, {String tag = "TAG"}) {
  _logger.w("$tag :: $msg");
}

logE(String msg, {String tag = "TAG"}) {
  _logger.e("$tag :: $msg");
}

logWTF(String msg, {String tag = "TAG"}) {
  _logger.wtf("$tag :: $msg");
}
