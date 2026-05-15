import 'package:colorist/screens/ai_chat_screen.dart';
import 'package:colorist/screens/home_screen.dart';
import 'package:colorist/screens/main_page.dart';
import 'package:colorist/screens/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeScreen = '/home';
  static const String aiChatScreen = '/aiChat';
  static const String notificationScreen = '/notification';
}

Route<dynamic> routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    case AppRoutes.aiChatScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AIChatScreen(),
      );
    case AppRoutes.notificationScreen:
      final message = settings.arguments as RemoteMessage;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => NotificationScreen(message: message),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const MainPage(),
      );
  }
}
