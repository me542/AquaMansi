import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/timecycle.dart';
import 'package:aquamansi_frontend/widget/execute.dart';
import 'package:aquamansi_frontend/service/notif.dart'; // Import NotificationService

class Setup extends StatefulWidget {
  final Function(String, {bool increment}) updateStageCount;

  const Setup({super.key, required this.updateStageCount});

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  int hours = 0;
  int hours2 = 0;
  Map<int, Map<String, dynamic>> sensors = {};

  @override
  void initState() {
    super.initState();
    NotificationService.requestPermission(context); // ✅ Request notification permission
  }

  void triggerOfflineNotification() {
    NotificationService.showNotification(
      "Aquamansi Alert",
      "Your system is currently offline!",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: sensors.keys.map((sensorPosition) {
                        final isEnabled = sensors[sensorPosition]?['enabled'] ?? false;

                        return GestureDetector(
                          onLongPress: () {},
                          onTap: isEnabled ? () {} : null,
                          child: Container(
                            width: 100,
                            height: 50,
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  TimeCycle(
                    hours: hours,
                    incrementHours: () {},
                    decrementHours: () {},
                  ),
                  const SizedBox(height: 16),
                  CountExecute(
                    hours2: hours2,
                    incrementHours2: () {},
                    decrementHours2: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            //✅ BUTTON TO TRIGGER NOTIFICATION
            FloatingActionButton(
              onPressed: triggerOfflineNotification,
              backgroundColor: Colors.white,
              child: const Icon(Icons.notifications, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
