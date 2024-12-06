import 'package:aquamansi_frontend/screen/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                        height: 100, // Adjust the height to fit
                        fit: BoxFit.contain, // Ensure the image scales appropriately
                      ),
                    ],
                  ),
                ),
              ),
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
                    // Navigate to DataScreen when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Data()),
                    );
                    print("Data button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('Data',
                  style: TextStyle(fontSize: 20),),
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
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                         title : const Center(
                         child: Text("User Manual"),
                         ),
                         content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('This app is for calamansi farmers. Here is a detailed user manual that guides you through the functionalities of this app. Follow these instructions carefully:\n\n'
                                    '1. Open the app and navigate through the main menu.\n'
                                    '2. Use the "Data" button to input or view data related to your farm.\n'
                                    '3. The "User Manual" button provides guidance on app usage.\n'
                                    '4. The "About" button provides information about this app.\n\n'
                                    'For further assistance, contact support.')
                            ],
                          ),
                         ),
                          actions: [
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                            }, child: const Text('close'))
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        );
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('User Manual',
                  style: TextStyle(fontSize: 20.0)
                  ),
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
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                         title : const Center(
                         child: Text("About AquaMansi"),
                         ),
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
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                            }, child: const Text('close'))
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        );
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CECAE), // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Custom button shape
                    ),
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    elevation: 8, // Elevation for shadow effect
                  ),
                  child: const Text('About',
                  style: TextStyle(fontSize: 20),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
