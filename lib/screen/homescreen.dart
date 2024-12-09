import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/indicator.dart';
import 'package:flutter/services.dart';
import 'menuoption.dart';
import 'package:aquamansi_frontend/widget/processcard.dart';
import 'package:aquamansi_frontend/widget/sensorsetup.dart';  // Import the sensor setup widget

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0), // Custom height for AppBar
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF4CECAE), // Status bar color
              statusBarIconBrightness: Brightness.dark, // Dark icons
              statusBarBrightness: Brightness.light, // For iOS
            ),
            child: SafeArea(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20), // Rounded corner for the bottom left
                  bottomRight: Radius.circular(20), // Rounded corner for the bottom right
                ),
                child: AppBar(
                  backgroundColor: const Color(0xFF4CECAE),
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                    children: [
                      Image.asset('asset/logo1.png', // Replace with your image asset path
                        height: 80, // Adjust the height to fit
                        fit: BoxFit.contain, // Ensure the image scales appropriately
                      ),
                    ],
                  ),
                  actions: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white), // Menu icon
                            iconSize: 45, // Custom size for the menu icon
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Menu(), // Ensure you have Menu class in 'menuoption.dart'
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                  percentage: 100,
                  stage: 'Young',
                  count: 3,
                  color: Colors.blue,
                  imagePath: 'asset/young.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Juvenile" stage with its specific image
                ProgressCard(
                  percentage: 50,
                  stage: 'Juvenile',
                  count: 4,
                  color: Colors.blue,
                  imagePath: 'asset/juvenile.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Matured" stage with its specific image
                ProgressCard(
                  percentage: 20,
                  stage: 'Matured',
                  count: 3,
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
