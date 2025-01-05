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
  int hours = 0;
  int hours2 = 0;

  Map<int, Map<String, dynamic>> sensors = {}; // Tracks sensors with properties

  void incrementHours() {
    setState(() {
      hours++;
    });
  }

  void decrementHours() {
    setState(() {
      if (hours > 1) hours--;
    });
  }

  void incrementHours2() {
    setState(() {
      hours2++;
    });
  }

  void decrementHours2() {
    setState(() {
      if (hours2 > 1) hours2--;
    });
  }

  void addSensor() {
    setState(() {
      int newSensorPosition = sensors.length + 1;
      sensors[newSensorPosition] = {
        "name": "Sensor $newSensorPosition",
        "stage": "Set Stage",
        "enabled": true, // Sensor is enabled by default
        "buttonName": "Sensor $newSensorPosition",
      };
    });
  }

  void deleteLastSensor() {
    setState(() {
      if (sensors.isNotEmpty) {
        final lastSensorPosition = sensors.keys.last;
        final removedSensor = sensors.remove(lastSensorPosition);

        if (removedSensor != null && removedSensor['stage'] != 'Set Stage') {
          widget.updateStageCount(removedSensor['stage'], increment: false);
        }
      }
    });
  }

  void toggleSensorState(int sensorPosition) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isEnabled = sensors[sensorPosition]?['enabled'] ?? false;
        return AlertDialog(
          title: const Text('Toggle Sensor State'),
          content: Text('Do you want to ${isEnabled ? "disable" : "enable"} this sensor?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  sensors[sensorPosition]?['enabled'] = !isEnabled;
                  final stage = sensors[sensorPosition]?['stage'];

                  if (isEnabled && stage != 'Set Stage') {
                    widget.updateStageCount(stage, increment: false);
                  } else if (!isEnabled && stage != 'Set Stage') {
                    widget.updateStageCount(stage);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void updateStage(int sensorPosition, String newStage) {
    setState(() {
      final oldStage = sensors[sensorPosition]?['stage'];
      final isEnabled = sensors[sensorPosition]?['enabled'] ?? false;

      if (oldStage != null && oldStage != newStage) {
        if (isEnabled && oldStage != 'Set Stage') {
          widget.updateStageCount(oldStage, increment: false);
        }

        sensors[sensorPosition]?['stage'] = newStage;
        sensors[sensorPosition]?['buttonName'] = "$sensorPosition T $newStage";

        if (isEnabled) {
          widget.updateStageCount(newStage);
        }
      }
    });
  }

  void showTreeStageOptions(int sensorPosition) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select the stage of tree for ${sensors[sensorPosition]?["name"]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Young'),
                onTap: () {
                  updateStage(sensorPosition, 'Young');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Juvenile'),
                onTap: () {
                  updateStage(sensorPosition, 'Juvenile');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Mature'),
                onTap: () {
                  updateStage(sensorPosition, 'Mature');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
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
                'Set your Trees',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / 3 - 10;
                    final itemHeight = 50.0;

                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: sensors.keys.map((sensorPosition) {
                        final isEnabled = sensors[sensorPosition]?['enabled'] ?? false;

                        return GestureDetector(
                          onLongPress: () => toggleSensorState(sensorPosition),
                          onTap: isEnabled
                              ? () => showTreeStageOptions(sensorPosition)
                              : null,
                          child: Container(
                            width: itemWidth,
                            height: itemHeight,
                            decoration: BoxDecoration(
                              color: isEnabled ? Colors.white : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              sensors[sensorPosition]?["buttonName"] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isEnabled ? Colors.black : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: addSensor,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: sensors.isNotEmpty ? deleteLastSensor : null,
                    backgroundColor: sensors.isNotEmpty ? Colors.red : Colors.grey,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
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
