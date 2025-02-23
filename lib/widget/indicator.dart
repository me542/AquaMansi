import 'package:flutter/material.dart';

class CircleLoadingIndicator extends StatefulWidget {
  @override
  _CircleLoadingIndicatorState createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  double progress = 0.0;
  bool isProcessComplete = false;
  bool isFinished = false;

  void handleButtonClick() async {
    setState(() {
      isProcessComplete = true;
    });

    await Future.delayed(Duration(seconds: 5));

    setState(() {
      isFinished = true;
      progress = 100.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Irrigation started!')),
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
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CECAE)),
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
                    'asset/icon3.png',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
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
              color: isFinished ? Colors.red : (isProcessComplete ? Colors.orange : Color(0xFF27B5D9)),
            ),
          ),
        ),
      ],
    );
  }
}
