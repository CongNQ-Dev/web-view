import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview/pages/main/home/index.dart';

import '../middlewares/router_auth.dart';
import '../pages/main/binding.dart';
import '../pages/main/view.dart';
import '../pages/otp_confirm/binding.dart';
import '../pages/otp_confirm/view.dart';
import '../pages/signin/binding.dart';
import '../pages/signin/view.dart';
import '../pages/welcome/binding.dart';
import '../pages/welcome/view.dart';
import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.initial,
        page: () => const WelcomePage(),
        binding: WelcomeBinding()),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.otpConfirm,
      page: () => const OtpConfirmPage(),
      binding: OtpConfirmBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: MainBinding(),
      // middlewares: [RouteAuthMiddleware(priority: 1)]
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
