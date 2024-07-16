import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/fab_bottom_app_bar.dart';
import '../../values/colors.dart';
import 'index.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: FABBottomAppBar(
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          ],
          backgroundColor: AppColors.primayBackground,
          notificationBadge: controller.state.notiCount.value,
          color: AppColors.primayBackground,
          selectedColor: AppColors.primaryElement,
          notchedShape: const CircularNotchedRectangle(),
          tabSelected: controller.state.tabSelected.value,
          onTabSelected: (value) => {controller.selectedTab(value)},
        ),
        body: controller.changePage()));
  }
}
