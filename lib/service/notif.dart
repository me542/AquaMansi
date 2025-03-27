import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart'; // For permission handling

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize the plugin
  static Future<void> init() async {
    try {
      // Request notification permission if targeting Android 13+
      if (await Permission.notification.isGranted == false) {
        await Permission.notification.request();
      }

      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  // Show notification when watering starts
  static Future<void> showStartNotification() async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_start_channel_v2', // Changed channel ID to force recreation
        'Watering Start Notifications',
        channelDescription: 'This notification alerts when watering starts.',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('start'), // Custom start sound
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.show(
        0, // ID 0 for the start notification
        'Watering Started',
        'The watering process has started. Please wait...',
        platformDetails,
      );
    } catch (e) {
      print('Error showing start notification: $e');
    }
  }

  // Show notification when watering is done
  static Future<void> showDoneNotification() async {
    try {
      // Cancel any ongoing "start" notifications
      await _flutterLocalNotificationsPlugin.cancel(0);

      const AndroidNotificationDetails androidDoneDetails = AndroidNotificationDetails(
        'watering_done_channel_v2', // Changed channel ID to force recreation
        'Watering Done Notifications',
        channelDescription: 'This notification alerts when watering is completed.',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('finished'), // Custom finished sound
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDoneDetails);

      // Show the "done" notification (ID 1)
      await _flutterLocalNotificationsPlugin.show(
        1, // ID 1 for the done notification
        'Watering Done',
        'The watering process is complete!',
        platformDetails,
      );
    } catch (e) {
      print('Error showing done notification: $e');
    }
  }
}
