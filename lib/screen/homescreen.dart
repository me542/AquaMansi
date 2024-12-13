import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/indicator.dart';
import 'package:aquamansi_frontend/widget/processcard.dart';
import 'package:aquamansi_frontend/widget/sensorsetup.dart';
import 'package:aquamansi_frontend/widget/appbar.dart';

void main() {
  runApp(const Homescreen());
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner globally
      home: Scaffold(
        appBar: const CustomAppBar(
          showBackArrow: false,
          showMenuButton: true,
        ), // Use the custom AppBar
        body: SingleChildScrollView(  // Make the body scrollable
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align content from the top
              crossAxisAlignment: CrossAxisAlignment.center, // Center the widgets horizontally
              children: [
                // Circle Loading Indicator as a separate widget
                CircleLoadingIndicator(), // Now it's used here

                const SizedBox(height: 16), // Add spacing between widgets

                // ProgressCard for "Young" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Young',
                  count: 0,
                  color: Colors.blue,
                  imagePath: 'asset/young.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Juvenile" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Juvenile',
                  count: 0,
                  color: Colors.blue,
                  imagePath: 'asset/juvenile.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Matured" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Matured',
                  count: 0,
                  color: Colors.blue,
                  imagePath: 'asset/mature.png', // Replace with your image
                ),

                // Add the Sensor Setup widget here
                const SizedBox(height: 16), // Optional spacing
                const Setup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
