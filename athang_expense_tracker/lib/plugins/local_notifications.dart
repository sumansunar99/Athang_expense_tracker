import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {
          // Handle notification response
        }
      },
    );

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(channel);
      print('Notification channel created: ${channel.id}');
    } else {
      print('Error: Could not resolve platform-specific implementation');
    }
  }

  Future<void> showNotification(String title, String body) async {
    try {
      await _flutterLocalNotificationsPlugin.show(
        1,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            importance: Importance.high,
            priority: Priority.high,
            setAsGroupSummary: true,
            icon: '@drawable/ic_launcher', // Make sure this icon exists
          ),
        ),
      );
      print('Notification shown: $title - $body');
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}