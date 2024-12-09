import 'package:flutter/material.dart';

class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  double progress = 50.0; // Example percentage
  bool isProcessComplete = false; // To track process state

  void handleButtonClick() {
    setState(() {
      isProcessComplete = true; // Mark process as complete
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image button clicked! Process done.')),
    );

    // Revert text back to "Start" after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isProcessComplete = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50), // Custom height before the first widget
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
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CECAE)),
              ),
            ),
            GestureDetector(
              onTap: handleButtonClick,
              child: Container(
                width: 180, // Custom width for the circle
                height: 180, // Custom height for the circle
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container circular
                  border: Border.all(color: Colors.transparent, width: 4), // Optional border
                ),
                child: ClipOval(
                  child: Image.asset(
                    'asset/icon3.png', // Replace with your image path
                    fit: BoxFit.cover, // Ensures the image fills the circle
                    width: 200, // Width of the image
                    height: 200, // Height of the image
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30), // Custom space between progress indicator and percentage text
        Text(
          '${progress.toInt()}%', // Display the progress percentage
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF27B5D9), // Custom color for the text
          ),
        ),
        SizedBox(height: 10), // Custom space between percentage text and Start/Finish text
        Text(
          isProcessComplete ? 'Finish' : 'Start', // Show text based on process state
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: isProcessComplete ? Colors.red : Color(0xFF27B5D9),
          ),
        ),
      ],
    );
  }
}
