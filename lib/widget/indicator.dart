import 'package:flutter/material.dart';
import 'package:Aquamansi/service/notif.dart'; // Import the NotificationsService class

class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  double progress = 0.0;
  bool isProcessComplete = false;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    NotificationsService.init(); // Initialize notifications
  }

  void handleButtonClick() async {
    if (isProcessComplete || isFinished) return; // Prevent multiple clicks

    setState(() {
      isProcessComplete = true;
    });

    await NotificationsService.showStartNotification();

    // Simulate watering process, but stop at 90%
    for (int i = 0; i <= 90; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        progress = i.toDouble();
      });
    }

    // Continue from 90% to 100%
    for (int i = 91; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        progress = i.toDouble();
      });
    }

    setState(() {
      isFinished = true;
      isProcessComplete = false;
    });

    await NotificationsService.showDoneNotification();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Irrigation process is complete!')),
    );

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isFinished = false;
      progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        GestureDetector(
          onTap: handleButtonClick,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isFinished ? Colors.green : Color(0xFF4CECAE),
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.transparent, width: 4),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'asset/icon3.png',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
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
              color: isFinished ? Colors.green : Color(0xFF27B5D9),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
