import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../values/colors.dart';
import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  Widget _buildPageHeadTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            color: AppColors.secondElement,
            fontWeight: FontWeight.bold,
            fontSize: 38.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryElement,
        body: Container(
          child: _buildPageHeadTitle(controller.title),
        ));
  }
}
