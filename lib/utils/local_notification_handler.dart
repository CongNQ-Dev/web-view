import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../values/colors.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("ic_launcher");
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        print(message.notification!.body);
      },
    );
  }

  static Future<NotificationDetails> notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'dbsapp',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      color: AppColors.primaryElement,
    );
    return NotificationDetails(android: androidNotificationDetails);
  }

  static Future<void> showNotificationWithAndroid(RemoteMessage message) async {
    flutterLocalNotificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        await notificationDetails(),
        payload: jsonEncode(message.toMap()));
  }
}
