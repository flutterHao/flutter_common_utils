import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../exports/common_lib.dart';

///@author lihonghao
///@date 2022/8/26
///@description

showToast(
  tips, {
  EasyLoadingToastPosition? toastPosition,
}) {
  EasyLoading.showToast(tips, toastPosition: toastPosition);
}

Future<bool> checkPermission() async {
  final status = await Permission.storage.request();
  if (status == PermissionStatus.granted) {
    return true;
  }
  return false;
}

Future<bool> checkNetState() async {
  ConnectivityResult connectState = await Connectivity().checkConnectivity();
  if (connectState == ConnectivityResult.none) {
    return true;
  }
  return false;
}
