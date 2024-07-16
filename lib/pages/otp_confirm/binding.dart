import 'package:get/get.dart';

import 'index.dart';

class OtpConfirmBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OtpConfirmController>(() => OtpConfirmController());
  }
}
