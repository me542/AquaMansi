import 'package:aquamansi_frontend/screen/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aquamansi_frontend/widget/appbar.dart'; // Import the CustomAppBar

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final TextEditingController _contactController = TextEditingController(); // Controller for the contact number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( // Using the CustomAppBar here
        showBackArrow: true, // Show the back arrow in the AppBar
        showMenuButton: false, // No need to show menu button in this screen
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
                    MaterialPageRoute(builder: (context) => const Data()),
                  );
                  print("Data button pressed");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4CECAE), // Custom text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Custom button shape
                  ),
                  shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                  elevation: 8, // Elevation for shadow effect
                ),
                child: const Text('Data', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20), // Space between buttons

            // Manual Use Button
            SizedBox(
              width: 359, // Custom width
              height: 70, // Custom height
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(child: Text("User Manual")),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'This app is for calamansi farmers. Here is a detailed user manual that guides you through the functionalities of this app. Follow these instructions carefully:\n\n'
                                      '1. Open the app and navigate through the main menu.\n'
                                      '2. Use the "Data" button to input or view data related to your farm.\n'
                                      '3. The "User Manual" button provides guidance on app usage.\n'
                                      '4. The "About" button provides information about this app.\n\n'
                                      'For further assistance, contact support.')
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('close'),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4CECAE), // Custom text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Custom button shape
                  ),
                  shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                  elevation: 8, // Elevation for shadow effect
                ),
                child: const Text('User Manual', style: TextStyle(fontSize: 20.0)),
              ),
            ),
            const SizedBox(height: 20), // Space between buttons

            // About Button
            SizedBox(
              width: 350, // Custom width
              height: 70, // Custom height
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(child: Text("About AquaMansi")),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'This app is specially designed to help calamansi farmers manage their farms more efficiently. It offers various features such as:\n\n'
                                      '1. Data Management: Keep track of your farming data, including harvest records, expenses, and yields.\n\n'
                                      '2. User Manual: Get detailed instructions on how to use the app and maximize its features.\n')
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('close'),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4CECAE), // Custom text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Custom button shape
                  ),
                  shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                  elevation: 8, // Elevation for shadow effect
                ),
                child: const Text('About', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20), // Space between buttons

            // Container for Contact Number (Sized the same as buttons)
            SizedBox(
              width: 350, // Same width as buttons
              height: 70, // Same height as buttons
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the container
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the container
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 5, // Blur of the shadow
                      offset: const Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _contactController, // Controller to manage input text
                  decoration: const InputDecoration(
                    labelText: 'Contact Number', // Label text
                    border: InputBorder.none, // No border for the TextField
                    hintText: 'Enter your contact number', // Hint text for the TextField
                  ),
                  keyboardType: TextInputType.phone, // Phone number input type
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
