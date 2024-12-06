import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Appbar extends StatelessWidget { // Changed to capital A
  final double logoHeight;

  // Constructor with the custom logo height parameter
  const Appbar({super.key, this.logoHeight = 80.0});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
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
                    height: logoHeight, // Use the customizable logo height
                    fit: BoxFit.contain, // Ensure the image scales appropriately
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
