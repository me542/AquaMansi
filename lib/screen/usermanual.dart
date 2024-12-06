import 'package:flutter/material.dart';

class UserManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar background color
        elevation: 0, // Remove shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center align the icon and text
          children: [
            Icon(
              Icons.settings, // Gear icon
              size: 32,
              color: Colors.grey,
            ),
            SizedBox(width: 8), // Space between icon and text
            Text(
              'How to use?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // Set the body background color to white
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          children: [
            Spacer(), // Push the button to the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns button to the right
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/1'); // Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.greenAccent, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded button
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Button padding
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
