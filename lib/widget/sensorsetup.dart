import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/timecycle.dart';
import 'package:aquamansi_frontend/widget/execute.dart';

class Setup extends StatefulWidget {
  final Function(String, {bool increment}) updateStageCount;

  const Setup({super.key, required this.updateStageCount});

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  int hours = 0; // Initial time in hours for the first cycle
  int hours2 = 0; // Initial count of execute
  List<String> sensors = []; // Initial sensors list
  Map<int, String> sensorStages = {}; // Map to track sensor stages (sensor index -> stage)
  Map<int, String> sensorButtonNames = {}; // Map to track sensor button names

  void incrementHours() {
    setState(() {
      hours++; // Increase first cycle hours by 1
    });
  }

  void decrementHours() {
    setState(() {
      if (hours > 1) {
        hours--; // Prevent hours from going below 1 for the first cycle
      }
    });
  }

  void incrementHours2() {
    setState(() {
      hours2++; // Increase second cycle hours by 1
    });
  }

  void decrementHours2() {
    setState(() {
      if (hours2 > 1) {
        hours2--; // Prevent hours from going below 1 for the second cycle
      }
    });
  }

  void addSensor() {
    setState(() {
      int nextSensorNumber = sensors.isEmpty
          ? 1
          : int.parse(sensors.last.split(' ').last) + 1;

      sensors.add('Sensor $nextSensorNumber');
      sensorButtonNames[nextSensorNumber - 1] = '${nextSensorNumber} Tree'; // Updated button name
    });
  }

  void deleteSensor(int index) {
    String sensor = sensors[index];

    if (sensorStages.containsKey(index)) {
      if (sensorStages[index] == 'Young') {
        widget.updateStageCount('Young', increment: false); // Decrease count for 'Young' stage
      } else if (sensorStages[index] == 'Juvenile') {
        widget.updateStageCount('Juvenile', increment: false); // Decrease count for 'Juvenile' stage
      } else if (sensorStages[index] == 'Mature') {
        widget.updateStageCount('Mature', increment: false); // Decrease count for 'Mature' stage
      }
    }

    setState(() {
      sensors.removeAt(index);
      sensorStages.remove(index);
      sensorButtonNames.remove(index);

      sensorStages = {
        for (var i = 0; i < sensors.length; i++) i: sensorStages[i + 1] ?? ''
      };
      sensorButtonNames = {
        for (var i = 0; i < sensors.length; i++) i: sensorButtonNames[i + 1] ?? ''
      };
    });
  }

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
                    if (sensorStages[index] != 'Young') {
                      if (sensorStages[index] == 'Juvenile') {
                        widget.updateStageCount('Juvenile', increment: false);
                      } else if (sensorStages[index] == 'Mature') {
                        widget.updateStageCount('Mature', increment: false);
                      }
                      sensorStages[index] = 'Young';
                      widget.updateStageCount('Young');
                      sensorButtonNames[index] = '${index + 1}T Young';
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Juvenile'),
                onTap: () {
                  setState(() {
                    if (sensorStages[index] != 'Juvenile') {
                      if (sensorStages[index] == 'Young') {
                        widget.updateStageCount('Young', increment: false);
                      } else if (sensorStages[index] == 'Mature') {
                        widget.updateStageCount('Mature', increment: false);
                      }
                      sensorStages[index] = 'Juvenile';
                      widget.updateStageCount('Juvenile');
                      sensorButtonNames[index] = '${index + 1}T Juvenile';
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Mature'),
                onTap: () {
                  setState(() {
                    if (sensorStages[index] != 'Mature') {
                      if (sensorStages[index] == 'Young') {
                        widget.updateStageCount('Young', increment: false);
                      } else if (sensorStages[index] == 'Juvenile') {
                        widget.updateStageCount('Juvenile', increment: false);
                      }
                      sensorStages[index] = 'Mature';
                      widget.updateStageCount('Mature');
                      sensorButtonNames[index] = '${index + 1}T Mature';
                    }
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
            color: Colors.lightBlueAccent.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set up Stages',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / 3 - 15;
                    final itemHeight = 50.0;

                    return Column(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
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
                                        sensorButtonNames[index] ?? 'Set Stage',
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
                      ],
                    );
                  },
                ),
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
              const SizedBox(height: 16),
              TimeCycle(
                hours: hours,
                incrementHours: incrementHours,
                decrementHours: decrementHours,
              ),
              const SizedBox(height: 16),
              CountExecute(
                hours2: hours2,
                incrementHours2: incrementHours2,
                decrementHours2: decrementHours2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
