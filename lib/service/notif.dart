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

  // Show notification when watering starts with a custom start sound (ID 0)
  static Future<void> showStartNotification() async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_channel_id',
        'Watering Channel',
        channelDescription: 'This is the notification for the start of the watering process.',
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('star'), // Custom start sound (ID 0)
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

  // Show notification when watering is done with a custom done sound (ID 1)
  static Future<void> showDoneNotification() async {
    try {
      // Cancel any ongoing "start" or "last execution" notifications
      await _flutterLocalNotificationsPlugin.cancel(0); // Cancel the "start" notification if still present
      await _flutterLocalNotificationsPlugin.cancel(2); // Cancel the "last execution" notification if still present

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_channel_id',
        'Watering Channel',
        channelDescription: 'This is the notification for the completion of the watering process.',
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('done'), // Custom done sound (ID 1)
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

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

  // Show the last execution notification (persistent until interacted with)
  static Future<void> showLastExecutionNotification() async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_channel_id',
        'Watering Channel',
        channelDescription: 'This notification remains until interacted with.',
        importance: Importance.high,
        priority: Priority.high,
        ongoing: true, // Makes the notification persistent
        sound: RawResourceAndroidNotificationSound('last'), // Custom last execution sound (ID 2)
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.show(
        2, // ID 2 for the last execution notification
        'Last Execution Active',
        'This is the last irrigation task. Tap to close it.',
        platformDetails,
      );
    } catch (e) {
      print('Error showing last execution notification: $e');
    }
  }

  // Dismiss the last execution notification
  static Future<void> dismissLastExecutionNotification() async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(2); // Cancel the last execution notification (ID 2)
    } catch (e) {
      print('Error dismissing last execution notification: $e');
    }
  }
}
