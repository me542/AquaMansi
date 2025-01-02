import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  int hours = 3; // Initial time in hours
  List<String> sensors = List.generate(6, (index) => 'Sensor ${index + 1}'); // Initial sensors list

  void incrementHours() {
    setState(() {
      hours++; // Increase hours by 1
    });
  }

  void decrementHours() {
    setState(() {
      if (hours > 1) {
        hours--; // Prevent hours from going below 1
      }
    });
  }

  // Function to add a new sensor
  void addSensor() {
    setState(() {
      // Find the next available sensor number
      int nextSensorNumber = sensors.length > 0 ? int.parse(sensors.last.split(' ').last) + 1 : 1;
      sensors.add('Sensor $nextSensorNumber');
    });
  }

  // Function to delete a sensor
  void deleteSensor(int index) {
    setState(() {
      sensors.removeAt(index);
    });
  }

  // Function to show the tree stage options for a sensor
  void showTreeStageOptions(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Stage for ${sensors[index]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                title: Text('Young'),
              ),
              ListTile(
                title: Text('Juvenile'),
              ),
              ListTile(
                title: Text('Mature'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.shade100, // Background color
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Set up Sensors',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Sensor Grid with custom sizes
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent, // Background color of the grid
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate custom width and height for grid items
                      final itemWidth = constraints.maxWidth / 3 - 15; // 3 columns with padding
                      final itemHeight = 50.0; // Fixed height for sensors

                      return Column(
                        children: [
                          // Sensor Grid with custom sizes
                          Wrap(
                            spacing: 8.0, // Horizontal spacing
                            runSpacing: 8.0, // Vertical spacing
                            children: List.generate(sensors.length, (index) {
                              return GestureDetector(
                                onTap: () => showTreeStageOptions(index), // Show options on tap
                                child: Container(
                                  width: itemWidth,
                                  height: itemHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: -12,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                          onPressed: () => deleteSensor(index),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          sensors[index],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 16), // Space between sensors and the add button

                          // Add Sensor Button inside the container
                          FloatingActionButton(
                            onPressed: addSensor, // Add new sensor
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Time Cycle Section
                const Text(
                  'Time cycle for irrigation monitoring',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),

                // Time Cycle Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Decrement Button
                    IconButton(
                      onPressed: decrementHours, // Call decrement logic
                      icon: const Icon(Icons.remove),
                      color: Colors.black,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Background color of time box
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$hours hrs', // Display current hours
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Increment Button
                    IconButton(
                      onPressed: incrementHours, // Call increment logic
                      icon: const Icon(Icons.add),
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: Setup()));
