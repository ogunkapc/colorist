import 'package:colorist/core/router/app_routes.dart';
import 'package:colorist/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotificationService {
  // Singleton instance
  static FirebaseNotificationService instance = FirebaseNotificationService._();

  FirebaseNotificationService._();

  // Instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize FCM
  Future<void> initializeFCM() async {
    // request permission from the user
    await _firebaseMessaging.requestPermission();

    // get FCM token for this device
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      // log token
      print('FCM Token: $fcmToken');
    } catch (e) {
      print('Failed to get FCM token: $e');
    }

    // initialize furthee settings for push notifications
    initFCMBackgroundSettings();
  }

  // function to handle received messages
  void _handleMessage(RemoteMessage? message) {
    // if no message, do nothing
    if (message == null) return;

    // navigate to notification screen when message is received and user taps on it
    navigatorKey.currentState?.pushNamed(
      AppRoutes.notificationScreen,
      arguments: message,
    );
  }

  // function to initialize background settings
  Future initFCMBackgroundSettings() async {
    // handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

    // attach event listeners for when a notification opens the app that is running in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // listen for messages when the app is running in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.notification?.title ?? 'New Notification'),
            action: SnackBarAction(
              label: 'View',
              onPressed: () {
                _handleMessage(message);
              },
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });
  }
}
