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
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '   The AQUAMANSI User Manual provides a comprehensive guide to operating the AQUAMANSI automated irrigation system and its companion mobile application. Designed with user-friendliness in mind, this manual serves as the ultimate reference for setting up, using, and maintaining both the device and the app.\n\n'
                      'Overview\n'
                      '   This manual outlines the essential features and functionalities of the AQUAMANSI system, which combines IoT technology with ease of use. The system, powered by an ESP8266 microcontroller and Arduino Mega, automates the irrigation of calamansi trees, ensuring efficient water usage and improved agricultural productivity.\n\n'
                      'Key Features\n'
                      '   Step-by-step instructions for connecting and pairing the AQUAMANSI device with the app.Detailed descriptions of features, such as setting irrigation time intervals, monitoring soil moisture levels, and sending SMS and app notifications.\n\n'
                      'Configuring the App for Remote Control via Local Wi-Fi:\n'
                      '1. Turn on the devices switch.\n'
                      '2. Open the users smartphone Wi-Fi settings.\n'
                      '3. Wait for initialization and scan for the AQUAMANSI localized network (Network Name: AQUAMANSI).\n'
                      '4. Connect the smartphone to the AQUAMANSI Wi-Fi network.\n\n'
                      'Safety and Maintenance\n\n'
                      'AQUAMANSI Device:\n'
                      '- Regularly inspect the water pump and pipes to ensure there are no leaks or loose connections.\n'
                      '- Check the circuit box for faulty wires and make sure all wires are securely connected and fastened appropriately.\n\n'
                      'AQUAMANSI App:\n'
                      '- Select the appropriate irrigation stage based on the trees monitored by each sensor.\n'
                      '- Double-check the irrigation time interval and the number of irrigation executions, as these will control the irrigation process.\n',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.5, // Line height
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns button to the right
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Home'); // Navigate to next screen
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
