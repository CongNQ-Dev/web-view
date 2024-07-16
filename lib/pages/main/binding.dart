import 'package:get/get.dart';
import 'package:webview/pages/main/home/controller.dart';

import 'index.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
