import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Aquamansi/hive/websocket.dart'; // Make sure to import your WebSocket service

class TimeCycle extends StatefulWidget {
  const TimeCycle({super.key});

  @override
  _TimeCycleState createState() => _TimeCycleState();
}

class _TimeCycleState extends State<TimeCycle> {
  late Box<int> settingsBox;
  int minutes = 0;
  final WebSocketService _webSocketService = WebSocketService();

  @override
  void initState() {
    super.initState();
    _initHive();
    _webSocketService.connect();

    _webSocketService.onMessage((message) {
      if (message.startsWith('{"irrigation_time"')) {
        final int receivedMinutes = int.tryParse(message.split(':')[1].split(',')[0]) ?? 0;
        setState(() {
          minutes = receivedMinutes;
          settingsBox.put('irrigation_time', minutes);
        });
      }
    });
  }

  Future<void> _initHive() async {
    settingsBox = await Hive.openBox<int>('settings');
    if (mounted) {
      setState(() {
        minutes = settingsBox.get('irrigation_time', defaultValue: 0)!;
      });
    }
  }

  String get formattedTime {
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;
    return '${hours}h:${remainingMinutes.toString().padLeft(2, '0')}mins';
  }

  void _updateMinutes(int newMinutes) {
    if (newMinutes >= 0 && newMinutes != minutes) {
      setState(() {
        minutes = newMinutes;
        settingsBox.put('irrigation_time', minutes);
        _webSocketService.sendMessage('SET_IRRIGATION_TIME:${formattedTime}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Irrigation Time Interval',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _updateMinutes(minutes - 15),
              icon: const Icon(Icons.remove),
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xCA8DF4C2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                minutes == 0 ? '0h:00min/s' : formattedTime,
                style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () => _updateMinutes(minutes + 15),
              icon: const Icon(Icons.add),
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }
}