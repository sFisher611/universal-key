import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    final notification = message.data['notification'];
  }
}

class FCM {
  final streamCtrl = StreamController<String>.broadcast();
  final titlCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidNotificationChannel channel;
  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    forgroundNotification();

    backgroundNotification();

    terminateNotification();
  }

  forgroundNotification() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      listenFCM(message);
      if (message.data.containsKey("data")) {
        streamCtrl.sink.add(message.data['data']);
      }

      if (message.data.containsKey('notification')) {
        streamCtrl.sink.add(message.data['notification']);
      }

      titlCtrl.sink.add(message.notification.title);
      bodyCtrl.sink.add(message.notification.body);
    });
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey("data")) {
        streamCtrl.sink.add(message.data['data']);
      }

      if (message.data.containsKey('notification')) {
        streamCtrl.sink.add(message.data['notification']);
      }

      titlCtrl.sink.add(message.notification.title);
      bodyCtrl.sink.add(message.notification.body);
    });
  }

  terminateNotification() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.containsKey("data")) {
        streamCtrl.sink.add(initialMessage.data['data']);
      }

      if (initialMessage.data.containsKey('notification')) {
        streamCtrl.sink.add(initialMessage.data['notification']);
      }

      titlCtrl.sink.add(initialMessage.notification.title);
      bodyCtrl.sink.add(initialMessage.notification.body);
    }
  }

  dispose() {
    streamCtrl.close();
    titlCtrl.close();
    bodyCtrl.close();
  }

  void listenFCM(RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, channel.name,
            //      one that already exists in example app.
            icon: '@mipmap/ic_launcher',
            // color: Colors.black,
          ),
        ),
      );
    }
  }
}
