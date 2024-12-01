import 'package:flutter/material.dart';

class menu extends StatefulWidget {
  const menu ({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _menuState();
}
class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0), // Custom height for AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20), // Rounded corner for the bottom left
              bottomRight: Radius.circular(20), // Rounded corner for the bottom right
            ),
            child: AppBar(
              backgroundColor: const Color(0xFF4CECAE),
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
             ), // AppBar background color
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
                    // Add your Data button action here
                    print("Data button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                  ),
                  child: const Text('Data'),
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
                  ),
                  child: const Text('Manual Use'),
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
                  ),
                  child: const Text('About'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}