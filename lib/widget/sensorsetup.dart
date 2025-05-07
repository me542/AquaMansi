import 'package:flutter/material.dart';
// import 'package:Aquamansi/widget/timecycle.dart';
// import 'package:Aquamansi/widget/execute.dart';
import 'package:Aquamansi/screen/sensor_model.dart';
import 'package:Aquamansi/hive/hive.dart'; // Import HiveService
import 'package:Aquamansi/hive/websocket.dart'; // Import WebSocketService

class Setup extends StatefulWidget {
  final Function(String, {bool increment}) updateStageCount;

  const Setup({super.key, required this.updateStageCount});

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  int hours = 0;
  int hours2 = 0;
  List<SensorModel> sensors = [];
  final WebSocketService _webSocketService = WebSocketService(); // FIX: Instance created

  @override
  void initState() {
    super.initState();
    _webSocketService.connect(); // Connect WebSocket on init
    _loadSensors();
  }

  Future<void> _loadSensors() async {
    sensors = HiveService.getAllSensors();
    setState(() {});
  }

  void addSensor() async {
    int newId = sensors.isEmpty ? 1 : sensors.last.id + 1;

    SensorModel newSensor = SensorModel(
      id: newId,
      name: "Sensor $newId",
      stage: "Set Stage",
      enabled: true,
      buttonName: "Sensor $newId",
    );

    await HiveService.saveSensor(newSensor);
    setState(() {
      sensors.add(newSensor);
    });

    // Send update to ESP8266
    _webSocketService.sendMessage('{"action": "ADD_SENSOR", "sensorId": $newId}');
  }

  void deleteLastSensor() async {
    if (sensors.isNotEmpty) {
      final lastSensor = sensors.removeLast();
      await HiveService.removeSensor(lastSensor.id);

      if (lastSensor.stage != 'Set Stage') {
        widget.updateStageCount(lastSensor.stage, increment: false);
      }

      setState(() {});

      // Notify ESP8266
      _webSocketService.sendMessage('{"action": "DELETE_SENSOR", "sensorId": ${lastSensor.id}}');
    }
  }

  void toggleSensorState(int sensorIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final sensor = sensors[sensorIndex];
        return AlertDialog(
          title: const Text('Toggle Sensor State'),
          content: Text('Do you want to ${sensor.enabled ? "disable" : "enable"} this sensor?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  sensor.enabled = !sensor.enabled;
                });

                await HiveService.saveSensor(sensor);

                if (sensor.stage != 'Set Stage') {
                  widget.updateStageCount(sensor.stage, increment: sensor.enabled);
                }

                // Notify ESP8266
                _webSocketService.sendMessage('{"action": "TOGGLE_SENSOR", "sensorId": ${sensor.id}, "enabled": ${sensor.enabled}}');

                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void updateStage(int sensorIndex, String newStage) async {
    final sensor = sensors[sensorIndex];

    if (sensor.stage != newStage) {
      if (sensor.enabled && sensor.stage != 'Set Stage') {
        widget.updateStageCount(sensor.stage, increment: false);
      }

      setState(() {
        sensor.stage = newStage;
        sensor.buttonName = "${sensor.id} T $newStage";
      });

      await HiveService.saveSensor(sensor);

      if (sensor.enabled) {
        widget.updateStageCount(newStage);
      }

      // Notify ESP8266
      _webSocketService.sendMessage('{"action": "UPDATE_STAGE", "sensorId": ${sensor.id}, "newStage": "$newStage"}');
    }
  }

  void showTreeStageOptions(int sensorIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select the stage of tree for ${sensors[sensorIndex].name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Young'),
                onTap: () {
                  updateStage(sensorIndex, 'Young');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Juvenile'),
                onTap: () {
                  updateStage(sensorIndex, 'Juvenile');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Mature'),
                onTap: () {
                  updateStage(sensorIndex, 'Mature');
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
            color: const Color(0x9278D8F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SET YOUR TREES',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF188097),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color(0xCA8DF4C2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / 3 - 10;
                    const itemHeight = 50.0;
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: sensors.asMap().entries.map((entry) {
                        int sensorIndex = entry.key;
                        SensorModel sensor = entry.value;
                        return GestureDetector(
                          onLongPress: () => toggleSensorState(sensorIndex),
                          onTap: sensor.enabled ? () => showTreeStageOptions(sensorIndex) : null,
                          child: Container(
                            width: itemWidth,
                            height: itemHeight,
                            decoration: BoxDecoration(
                              color: sensor.enabled ? Colors.white : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              sensor.buttonName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: sensor.enabled ? Colors.black : Colors.grey.shade700,
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
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: sensors.isNotEmpty ? deleteLastSensor : null,
                    backgroundColor: sensors.isNotEmpty ? Colors.red : Colors.grey,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
              // const SizedBox(height: 16),
              // TimeCycle(),
              // const SizedBox(height: 16),
              // CountExecute(),
            ],
          ),
        ),
      ),
    );
  }
}