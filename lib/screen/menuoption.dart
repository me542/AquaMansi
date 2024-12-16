import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:aquamansi_frontend/screen/data.dart'; // Your other screen
import 'package:aquamansi_frontend/widget/appbar.dart'; // Your Custom AppBar
import 'package:aquamansi_frontend/widget/contact.dart'; // Importing the new widget

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final TextEditingController _contactController = TextEditingController(); // Controller for the contact number
  late WebSocketChannel _channel;  // WebSocket channel to communicate with ESP32
  String _contactNumber = ''; // Variable to store the received contact number

  @override
  void initState() {
    super.initState();

    // Connect to the WebSocket server hosted by ESP32
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.0:81'), // Replace with your ESP32 IP address
    );

    // Listen for incoming messages (contact number from ESP32)
    _channel.stream.listen((message) {
      setState(() {
        _contactNumber = message;  // Update the contact number when received
        _contactController.text = _contactNumber; // Show the received contact number
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();  // Close WebSocket connection when widget is disposed
    super.dispose();
  }

  // Function to limit the contact number to 11 digits
  void _onContactNumberChanged(String value) {
    if (value.length <= 11) {
      setState(() {
        _contactNumber = value;
      });
    }
  }

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
              width: 350,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Data()),  // Pushing Data screen onto the stack
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4CECAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 8,
                ),
                child: const Text('Data', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),

            // Manual Use Button
            SizedBox(
              width: 350,
              height: 70,
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
                                  'This app is for calamansi farmers. Here is a detailed user manual that guides you through the functionalities of this app.\n\n'
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
                  backgroundColor: const Color(0xFF4CECAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 8,
                ),
                child: const Text('User Manual', style: TextStyle(fontSize: 20.0)),
              ),
            ),
            const SizedBox(height: 20),

            // About Button
            SizedBox(
              width: 350,
              height: 70,
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
                  backgroundColor: const Color(0xFF4CECAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 8,
                ),
                child: const Text('About', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Number Widget
            ContactNumber(
              contactController: _contactController,
              initialContactNumber: _contactNumber,
              onContactNumberChanged: _onContactNumberChanged,
            ),
          ],
        ),
      ),
    );
  }
}
