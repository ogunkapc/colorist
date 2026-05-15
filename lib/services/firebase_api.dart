import 'package:colorist/core/router/app_routes.dart';
import 'package:colorist/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // Instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from the user
    await _firebaseMessaging.requestPermission();

    // get FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    // log token
    print('FCM Token: $fcmToken');

    // initialize furthee settings for push notifications
    initPushNotifications();
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // if no message, do nothing
    if (message == null) return;

    // navigate to notification screen when message is received and user taps on it
    navigatorKey.currentState?.pushNamed(
      AppRoutes.notificationScreen,
      arguments: message,
    );
  }

  // function to initialize background settings
  Future initPushNotifications() async {
    // handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
