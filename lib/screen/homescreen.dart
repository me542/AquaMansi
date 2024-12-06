import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menuoption.dart'; // Make sure this file contains the 'Menu' class.

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
                      Image.asset(
                        'lib/asset/logo1.png', // Replace with your image asset path
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
                              // Fixed the Navigator.push() call
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
      ),
    );
  }
}

void main() {
  runApp(const Homescreen());
}
