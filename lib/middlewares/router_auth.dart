import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../store/customer.dart';
import '../utils/helper.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (isExpiredToken(CustomerStore.to.profile.dateLogin ?? "",
            CustomerStore.to.profile.expiresIn ?? -1) ||
        route == AppRoutes.signin ||
        route == AppRoutes.initial) {
      return null;
    } else {
      CustomerStore.to.clearStorage();
      return const RouteSettings(name: AppRoutes.signin);
    }
  }
}
