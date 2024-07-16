import 'package:get/get.dart';

import 'index.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
