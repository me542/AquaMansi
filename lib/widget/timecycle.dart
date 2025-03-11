import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../hive/websocket.dart';

class TimeCycle extends StatefulWidget {
  const TimeCycle({super.key});

  @override
  _TimeCycleState createState() => _TimeCycleState();
}

class _TimeCycleState extends State<TimeCycle> {
  late Box<int> settingsBox;
  int minutes = 0;
  late WebSocketService webSocketService;

  @override
  void initState() {
    super.initState();
    _initHive();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenToWebSocket();
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

  void _listenToWebSocket() {
    webSocketService = Provider.of<WebSocketService>(context, listen: false);
    webSocketService.addListener(_updateFromWebSocket);
  }

  void _updateFromWebSocket() {
    final newMinutes = webSocketService.irrigationInterval;
    if (newMinutes != null && newMinutes != minutes) {
      setState(() {
        minutes = newMinutes;
        settingsBox.put('irrigation_time', minutes);
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
      });

      webSocketService.sendMessage('SET_INTERVAL:$newMinutes');
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
    webSocketService.removeListener(_updateFromWebSocket);
    super.dispose();
  }
}
