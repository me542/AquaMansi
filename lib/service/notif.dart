// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initSettings =
//     InitializationSettings(android: androidSettings);
//
//     await _notificationsPlugin.initialize(initSettings);
//   }
//
//   static Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'aqumansi_channel', // Unique channel ID
//       'Aquamansi Notifications', // Channel name
//       channelDescription: 'Notifications for Aquamansi app',
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('custom_notif_sound'), // Without .mp3 extension
//     );
//
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//     await _notificationsPlugin.show(
//       0, // Notification ID
//       title, // Title
//       body, // Body
//       notificationDetails,
//     );
//   }
// }
