// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationHelper {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   NotificationHelper() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _initializeNotifications();
//   }
//
//   void _initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap
//         print("Notification clicked: ${response.payload}");
//       },
//     );
//   }
//
//   Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'aquamansi_channel',
//       'Aquamansi Notifications',
//       channelDescription: 'Channel for soil moisture alerts',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       title,
//       body,
//       platformDetails,
//       payload: 'Aquamansi notification payload',
//     );
//   }
// }
