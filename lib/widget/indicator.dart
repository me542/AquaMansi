import 'package:flutter/material.dart';

class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  double progress = 0.0; // Example percentage
  bool isProcessComplete = false; // To track process state
  bool isFinished = false; // To track if "Finish" is displayed

  void handleButtonClick() async {
    setState(() {
      isProcessComplete = true; // Start the process
    });

    await Future.delayed(Duration(seconds: 5)); // Delay for 5 seconds

    // Show the popup dialog
    bool? result = await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('IRRIGATE TREES WITH WET SOIL?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Return true if Yes is pressed
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Return false if No is pressed
              child: Text('No'),
            ),
          ],
        );
      },
    );

    await Future.delayed(Duration(seconds: 5)); // Delay for another 5 seconds

    setState(() {
      isFinished = true; // Mark as finished
      progress = 100.0; // Update progress to 100%
    });

    // Optionally, handle the result of the dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result == true ? 'Irrigation started!' : 'Irrigation canceled!')),
    );

    await Future.delayed(Duration(seconds: 3)); // Delay for 3 seconds after finish

    setState(() {
      isFinished = false;
      isProcessComplete = false; // Reset to "Start"
      progress = 0.0; // Reset progress
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
          isFinished ? 'Finish' : (isProcessComplete ? 'Processing...' : 'Start'), // Show text based on process state
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: isFinished ? Colors.red : (isProcessComplete ? Colors.orange : Color(0xFF27B5D9)),
          ),
        ),
      ],
    );
  }
}
