import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0), // Custom height for AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20), // Rounded corner for the bottom left
              bottomRight: Radius.circular(20), // Rounded corner for the bottom right
            ),
            child: AppBar(
            backgroundColor: const Color(0xFF4CECAE), // AppBar background color
            flexibleSpace: const Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align content at the bottom
              children: [
                Text(
                  'AquaMansi',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 131, 20, 1),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu), // Menu icon on the right
                onPressed: () {
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