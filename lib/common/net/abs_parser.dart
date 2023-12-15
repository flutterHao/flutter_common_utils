import 'package:dio/dio.dart';

///@author huangjianghe
///@date 2022/7/19
abstract class AbsParser {
  parse<T>(Response response);
}
