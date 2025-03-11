import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart'; // For permission handling

class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  double progress = 0.0;
  bool isProcessComplete = false;
  bool isFinished = false;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // Initialize notifications
  void _initializeNotifications() async {
    // Request notification permission if targeting Android 13+
    if (await Permission.notification.isGranted == false) {
      await Permission.notification.request();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show notification for the start of the irrigation process
  Future<void> _showStartNotification() async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_channel_id',
        'Watering Channel',
        channelDescription: 'Notification channel for watering process (start)', // Updated description
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('star'), // Custom start sound
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.show(
        0,
        'Watering Started',
        'The watering process has started. Please wait...',
        platformDetails,
      );
    } catch (e) {
      print('Error showing start notification: $e');
    }
  }

  Future<void> _showDoneNotification() async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'watering_channel_id',  // Channel ID
        'Watering Channel',     // Channel Name
        channelDescription: 'Notification channel for completed watering process', // Updated description
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('done'), // Custom sound for 'done'
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      // Display the notification
      await _flutterLocalNotificationsPlugin.show(
        1,  // Notification ID
        'Watering Done', // Title
        'The watering process is complete!', // Message
        platformDetails, // Platform-specific notification details
      );
    } catch (e) {
      print('Error showing done notification: $e');
    }
  }


  // Handle button click to start and finish the process
  void handleButtonClick() async {
    if (isProcessComplete || isFinished) return; // Prevent clicking while process is already complete

    setState(() {
      isProcessComplete = true;
    });

    await _showStartNotification();

    // Simulate watering process with progress updates
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        progress = i.toDouble();
      });
    }

    setState(() {
      isFinished = true;
    });

    // Show the "done" notification after the process completes
    await _showDoneNotification();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Irrigation process is complete!')),
    );

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isFinished = false;
      isProcessComplete = false;
      progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progress / 100,
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(isFinished ? Colors.green : Color(0xFF4CECAE)), // Green when done
              ),
            ),
            GestureDetector(
              onTap: handleButtonClick,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.transparent, width: 4),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'asset/icon3.png', // Change this to your desired icon
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${progress.toInt()}%',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF27B5D9),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: handleButtonClick,
          child: Text(
            isFinished ? 'Finish' : (isProcessComplete ? 'Processing...' : 'Start'),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: isFinished
                  ? Colors.green
                  : (isProcessComplete ? Color(0xFF27B5D9) : Color(0xFF27B5D9)),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
