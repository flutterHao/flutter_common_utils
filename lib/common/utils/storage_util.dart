import 'package:get_storage/get_storage.dart';

///@author huangjianghe
///@date 2022/7/18
///数据的存取
class StorageUtil {
  //从缓存中读写
  static read(String key) {
    return GetStorage().read(key);
  }

  static write(String key, value) {
    GetStorage().write(key, value);
  }

  static hasData(String key) {
    return GetStorage().hasData(key);
  }

  static cleanAll() {
    GetStorage().erase();
  }

  static remove(String key) {
    GetStorage().remove(key);
  }

  static clean(String key) {
    GetStorage().remove(key);
  }
}
