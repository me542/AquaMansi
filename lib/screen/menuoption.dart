import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:aquamansi_frontend/screen/data.dart'; // Your other screen
import 'package:aquamansi_frontend/widget/appbar.dart'; // Your Custom AppBar
// import 'package:aquamansi_frontend/widget/contact.dart'; // Importing the new widget

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
  // void _onContactNumberChanged(String value) {
  //   if (value.length <= 11) {
  //     setState(() {
  //       _contactNumber = value;
  //     });
  //   }
  // }

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
                        title: const Center(child: Text("AQUAMANSI User Manual")),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '   The AQUAMANSI User Manual provides a comprehensive guide to operating the AQUAMANSI automated irrigation system and its companion mobile application. Designed with user-friendliness in mind, this manual serves as the ultimate reference for setting up, using, and maintaining both the device and the app.\n\n'
                                      'Overview\n'
                                      '   This manual outlines the essential features and functionalities of the AQUAMANSI system, which combines IoT technology with ease of use. The system, powered by an ESP8266 microcontroller and Arduino Mega, automates the irrigation of calamansi trees, ensuring efficient water usage and improved agricultural productivity.\n\n'
                                      'Key Features\n'
                                      '   Step-by-step instructions for connecting and pairing the AQUAMANSI device with the app.Detailed descriptions of features, such as setting irrigation time intervals, monitoring soil moisture levels, and sending SMS and app notifications.\n\n'
                                      'Configuring the App for Remote Control via Local Wi-Fi:\n'
                                      '1. Turn on the devices switch.\n'
                                      '2. Open the users smartphone Wi-Fi settings.\n'
                                      '3. Wait for initialization and scan for the AQUAMANSI localized network (Network Name: AQUAMANSI).\n'
                                      '4. Connect the smartphone to the AQUAMANSI Wi-Fi network.\n\n'
                                      'Safety and Maintenance\n\n'
                                      'AQUAMANSI Device:\n'
                                      '- Regularly inspect the water pump and pipes to ensure there are no leaks or loose connections.\n'
                                      '- Check the circuit box for faulty wires and make sure all wires are securely connected and fastened appropriately.\n\n'
                                      'AQUAMANSI App:\n'
                                      '- Select the appropriate irrigation stage based on the trees monitored by each sensor.\n'
                                      '- Double-check the irrigation time interval and the number of irrigation executions, as these will control the irrigation process.\n')
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
                        title: const Center(child: Text("About AquaMansi App")),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'AQUAMANSI v1.0\n'
                                      'Copyright © 2025 GROUP 6 Team\n'
                                      'Calamansi\n\n'
                                      'App Description\n'
                                      '   AQUAMANSI is a remote application designed specifically for the AQUAMANSI automated irrigation system. It serves as the primary controller for the device, which is an IoT-enabled system primarily powered by an ESP8266 microcontroller and Arduino Mega. This smart and automatic solution is tailored for the irrigation of calamansi trees, ensuring efficient and intelligent watering.\n\n'
                                      'Developed By:\n'
                                      'GROUP 6\n'
                                      'Stephanie Anrish U. Tañedo\n'
                                      'Noemi C. Estrella\n'
                                      'Jomari H. Ecal\n'
                                      'Reyvin F. Flor\n'
                                      'Marvin O. Lingatong\n'
                                      'Earielle John M. Del Mundo\n'
                                      'Jhanren Jules C. Pandanan\n\n'
                                      'Links:\n'
                                      'Google Drive: Link soon available\n'
                                      'Contact: Unavilable\n'
                                      'Version History:\n'
                                      'Version 1.0')
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
            // ContactNumber(
            //   contactController: _contactController,
            //   initialContactNumber: _contactNumber,
            //   onContactNumberChanged: _onContactNumberChanged,
            // ),
          ],
        ),
      ),
    );
  }
}
