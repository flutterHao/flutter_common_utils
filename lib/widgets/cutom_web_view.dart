import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_bar.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({Key? key, this.title, required this.url})
      : super(key: key);
  final String? title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        title: title ?? "",
        body: WebView(
          initialUrl: url,
          backgroundColor: Colors.white,
        ));
  }
}
