import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
