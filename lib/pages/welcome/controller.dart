import 'package:get/get.dart';

import '../../routes/routes.dart';
import 'index.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = "DBS";
  final state = WelcomeState();

  @override
  Future<void> onReady() async {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offAllNamed(AppRoutes.main);
    });
  }
}
