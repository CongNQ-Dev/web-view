import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'index.dart';

class HomeController extends GetxController {
  HomeController();
  final state = HomeState();
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse('https://flutter.dev'),
    );

  ScrollController myScrollController = ScrollController();

  @override
  Future<void> onInit() async {
    super.onInit();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var data = Get.parameters;
    state.tabSelected.value =
        data['tabSelected'] != null ? int.parse(data['tabSelected']!) : 0;
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    myScrollController.dispose();
  }
}
