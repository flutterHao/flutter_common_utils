import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_lib_shared/common/net/net_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'common_util.dart';

///author:Hao
///date:2020/08/24
///discrible:文件处理

class FileUtils {
  //文件选择
  static Future<XFile?> filePicker(
      {FileType type = FileType.any, List<String>? allowedExtensions}) async {
    XFile? file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      if (fileBytes != null) {
        file = XFile.fromData(fileBytes, name: fileName);
      }
    }
    return file;
  }

  //文件上传
  static uploadFile<T>(XFile xFile, String uploadUrl, Function(T) onSuccess,
      {bool isWithLoading = false}) async {
    // MultipartFile file = await MultipartFile.fromFile(path, filename: fileName);//web 不支持 MultipartFile.fromFile
    Uint8List fileBytes = await xFile.readAsBytes();
    var file = MultipartFile.fromBytes(fileBytes, filename: xFile.name);
    FormData data = FormData.fromMap({"file": file});
    netManager.post<T>(uploadUrl, params: data, onSuccess: (result) {
      onSuccess(result);
    }, onError: (e) {}, isWithLoading: isWithLoading, tips: 'Loading..');
  }

  static deleteFile(
      String fileUrl, String uploadUrl, Function onSuccess) async {
    netManager.post(uploadUrl, queryParams: {"fileName": fileUrl},
        onSuccess: (result) {
      onSuccess(result);
    });
  }
}
