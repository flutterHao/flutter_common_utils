import 'package:flutter/material.dart';
class ImageUtil {
  static asset( String name,
      {  double? width,
        double? height,
      String package = 'flutter_lib_shared'}) {

    return Image.asset(name, width: width, height: height, package: package);
  }
}
