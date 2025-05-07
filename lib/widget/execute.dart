import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../hive/hive.dart';
import 'package:Aquamansi/hive/websocket.dart'; // Make sure to import your WebSocket service

class CountExecute extends StatefulWidget {
  const CountExecute({super.key});

  @override
  _CountExecuteState createState() => _CountExecuteState();
}

class _CountExecuteState extends State<CountExecute> {
  late Box<int> _hoursBox;
  bool _isBoxInitialized = false;
  final WebSocketService _webSocketService = WebSocketService();

  @override
  void initState() {
    super.initState();
    _initHive();
    _webSocketService.connect();

    _webSocketService.onMessage((message) {
      if (message.startsWith('{"execution_count"')) {
        final int receivedCount = int.tryParse(message.split(':')[1].split(',')[0]) ?? 0;
        if (_isBoxInitialized) {
          setState(() {
            _hoursBox.put('hours2', receivedCount);
          });
        }
      }
    });
  }

  Future<void> _initHive() async {
    await HiveService.init();
    _hoursBox = Hive.box<int>('execution_count');
    if (!_hoursBox.containsKey('hours2')) {
      _hoursBox.put('hours2', 0);
    }
    setState(() {
      _isBoxInitialized = true;
    });
  }

  int get hours2 => _isBoxInitialized ? _hoursBox.get('hours2', defaultValue: 0)! : 0;

  void updateExecutionCount(int newCount) {
    if (_isBoxInitialized) {
      setState(() {
        _hoursBox.put('hours2', newCount);
      });
      _webSocketService.sendMessage('SET_EXECUTION_COUNT:$newCount');
    }
  }

  void incrementHours2() => updateExecutionCount(hours2 + 1);
  void decrementHours2() {
    if (hours2 > 0) updateExecutionCount(hours2 - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Number of Execution',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: decrementHours2,
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
                _isBoxInitialized ? '$hours2 Time/s' : 'Loading...',
                style: const TextStyle(
                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: incrementHours2,
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