import 'package:aquamansi_frontend/screen/data.dart'; // Import the file that contains DataScreen
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                      Image.asset(
                        'lib/asset/logo1.png', // Replace with your image asset path
                        height: 100, // Adjust the height to fit
                        fit: BoxFit.contain, // Ensure the image scales appropriately
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center( // Ensures everything inside is centered
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrinks the column to fit its children
            children: [
              // Data Button
              SizedBox(
                width: 350, // Custom width
                height: 70, // Custom height
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to DataScreen when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Data()),
                    );
                    print("Data button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('Data',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between buttons

              // Manual Use Button
              SizedBox(
                width: 359, // Custom width
                height: 70, // Custom height
                child: ElevatedButton(
                  onPressed: () {
                    // Add your Manual Use button action here
                    print("Manual Use button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('User Manual',
                      style: TextStyle(fontSize: 20.0)
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between buttons

              // About Button
              SizedBox(
                width: 350, // Custom width
                height: 70, // Custom height
                child: ElevatedButton(
                  onPressed: () {
                    // Add your About button action here
                    print("About button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('About',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
