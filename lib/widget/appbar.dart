import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0), // Custom height for AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), // Rounded corner for the bottom left
              bottomRight: Radius.circular(30), // Rounded corner for the bottom right
            ),
            child: AppBar(
              title: const Text('Aquamansi'), // Title of the AppBar
              centerTitle: true, // Centers the title
              backgroundColor: Color(0xFF4CECAE), // AppBar background color
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu), // Menu icon on the right
                  onPressed: () {
                    // Action when the menu icon is pressed
                    print('Menu pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}