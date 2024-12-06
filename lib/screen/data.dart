import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          // Custom height for AppBar
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
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white), // White arrow
                    iconSize: 40.0, // Custom size for the back arrow
                    onPressed: () {
                      Navigator.of(context).pop(); // Go back to the previous screen
                    },
                  ),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
