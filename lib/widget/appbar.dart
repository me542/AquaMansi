import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/menuoption.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackArrow; // Parameter to control back arrow visibility
  final bool showMenuButton; // Parameter to control menu button visibility

  const CustomAppBar({
    Key? key,
    this.showBackArrow = true, // Default: no back arrow
    this.showMenuButton = true, // Default: show menu button
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(110.0); // Custom height for AppBar

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xCA8DF4C2), // Status bar color
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
            backgroundColor: const Color(0xCA8DF4C2),
            leading: showBackArrow
                ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);  // This will pop the current screen (Data) and return to Menu
              },
            )
                : Container(), // No back arrow
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                Image.asset(
                  'asset/logo1.png', // Replace with your image asset path
                  height: 80, // Adjust the height to fit
                  fit: BoxFit.contain, // Ensure the image scales appropriately
                ),
              ],
            ),
            actions: [
              if (showMenuButton)
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white), // Menu icon
                  iconSize: 45, // Custom size for the menu icon
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Menu(), // Ensure you have Menu class in 'menuoption.dart'
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
