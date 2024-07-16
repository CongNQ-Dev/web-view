import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'firebase_options.dart';
import 'store/customer.dart';
import 'store/storage.dart';
import 'utils/firebase_messaging_handler.dart';
import 'utils/local_notification_handler.dart';

class Global {
  static WebViewController? webViewController;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      LocalNotificationService.initialize();
    }
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInit().whenComplete(() => FirebaseMessagingHandler.config());
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<CustomerStore>(CustomerStore());
  }

  static Future firebaseInit() async {
    FirebaseMessaging.onBackgroundMessage(
        FirebaseMessagingHandler.firebaseMessagingBackground);
  }
}
