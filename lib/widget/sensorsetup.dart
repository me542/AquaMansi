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
      // Find the next available sensor number by looking for the highest number in the existing sensors list
      int nextSensorNumber = sensors
          .where((sensor) => sensor.startsWith('Sensor'))
          .map((sensor) => int.parse(sensor.split(' ').last))
          .fold(0, (prev, curr) => curr > prev ? curr : prev) + 1;

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
            children: [
              ListTile(
                title: const Text('Young'),
                onTap: () {
                  setState(() {
                    sensors[index] = 'S${index + 1} Young'; // Update sensor name
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Juvenile'),
                onTap: () {
                  setState(() {
                    sensors[index] = 'S${index + 1} Juvenile'; // Update sensor name
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Mature'),
                onTap: () {
                  setState(() {
                    sensors[index] = 'S${index + 1} Mature'; // Update sensor name
                  });
                  Navigator.of(context).pop();
                },
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
    return Padding(
      padding: const EdgeInsets.all(0),
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Sensor Grid
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
                        Wrap(
                          spacing: 8.0, // Horizontal spacing
                          runSpacing: 8.0, // Vertical spacing
                          children: List.generate(sensors.length, (index) {
                            return GestureDetector(
                              onTap: () => showTreeStageOptions(index),
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
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: addSensor,
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
              const Text(
                'Time cycle for irrigation monitoring',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: decrementHours,
                    icon: const Icon(Icons.remove),
                    color: Colors.black,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$hours hrs',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: incrementHours,
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
