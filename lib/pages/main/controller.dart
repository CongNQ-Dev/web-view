import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home/view.dart';
import 'index.dart';

class MainController extends GetxController {
  MainController();
  final state = MainState();

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

  void selectedTab(int index) {
    state.tabSelected.value = index;
  }

  Widget changePage() {
    Widget content = Container();
    switch (state.tabSelected.value) {
      case 0:
        content = const HomePage();
        break;
    }
    return content;
  }

  Widget changeTitleAppbar() {
    Text content = const Text('');
    switch (state.tabSelected.value) {
      case 0:
        content = const Text('Home');
        break;
    }
    return content;
  }

  @override
  void onClose() {
    super.onClose();
    myScrollController.dispose();
  }
}
