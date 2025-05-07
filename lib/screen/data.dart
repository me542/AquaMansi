import 'package:flutter/material.dart';
import 'package:Aquamansi/widget/appbar.dart';
import 'package:Aquamansi/hive/hive.dart';
import 'dart:async';
import 'package:Aquamansi/hive/websocket.dart'; // Import WebSocket service

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  List<DataRow> dataRows = [];
  final WebSocketService _webSocketService = WebSocketService(); // Initialize WebSocketService

  @override
  void initState() {
    super.initState();
    _webSocketService.connect(); // Connect WebSocket
    _webSocketService.onMessage(_handleWebSocketMessage);
    Future.microtask(() async {
      await _loadStoredData(); // Load stored Hive data on startup
    });
  }

  /// Load previously stored data from Hive
  Future<void> _loadStoredData() async {
    List<Map<String, String>> storedEntries = await HiveService.getData();

    // Sample data for display if no Hive data found
    if (storedEntries.isEmpty) {
      storedEntries = [
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 1',
          'stage': 'matured',
          'soilMoisture': '20%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 2',
          'stage': 'matured',
          'soilMoisture': '24%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 3',
          'stage': 'matured',
          'soilMoisture': '22%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 4',
          'stage': 'matured',
          'soilMoisture': '16%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 5',
          'stage': 'matured',
          'soilMoisture': '22%',
        },
        {
          'dateTime': '2025-04-4 03:14',
          'sensorId': 'Sensor 6',
          'stage': 'young',
          'soilMoisture': '23%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 7',
          'stage': 'young',
          'soilMoisture': '18%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 8',
          'stage': 'young',
          'soilMoisture': '20%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 9',
          'stage': 'juvenile',
          'soilMoisture': '15%',
        },
        {
          'dateTime': '2025-04-4 08:30',
          'sensorId': 'Sensor 10',
          'stage': 'juvenile',
          'soilMoisture': '29%',
        },
      ];
    }

    List<DataRow> storedRows = _mapDataToRows(storedEntries);
    if (mounted) {
      setState(() => dataRows = storedRows);
    }
  }

  /// Handles incoming WebSocket messages and updates UI
  void _handleWebSocketMessage(String message) {
    try {
      List<String> parts = message.split(',');
      if (parts.length == 4) {
        Map<String, String> entry = {
          'dateTime': parts[0],
          'sensorId': parts[1],
          'stage': parts[2],
          'soilMoisture': parts[3],
        };
        setState(() {
          dataRows.insert(0, _createDataRow(entry));
        });
      }
    } catch (e) {
      print("Error processing WebSocket message: $e");
    }
  }

  /// Maps data into DataRow objects
  List<DataRow> _mapDataToRows(List<Map<String, String>> entries) {
    return entries.map(_createDataRow).toList();
  }

  DataRow _createDataRow(Map<String, String> entry) {
    return DataRow(cells: [
      DataCell(Text(entry['dateTime'] ?? 'Unknown')),
      DataCell(Text(entry['sensorId'] ?? 'Unknown')),
      DataCell(Text(entry['stage'] ?? 'Unknown')),
      DataCell(Text(entry['soilMoisture'] ?? 'Unknown')),
    ]);
  }

  /// Sends fetch request to WebSocket
  void _fetchLiveData() {
    _webSocketService.sendMessage("FETCH_DATA");
  }

  @override
  void dispose() {
    _webSocketService.disconnect(); // Disconnect WebSocket when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        showMenuButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Date & Time')),
                    DataColumn(label: Text('Sensor ID')),
                    DataColumn(label: Text("Stages")),
                    DataColumn(label: Text("Soil Moisture")),
                  ],
                  rows: dataRows,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _fetchLiveData, // Fetch live data from ESP8266
            child: const Text('Fetch Data'),
          ),
        ],
      ),
    );
  }
}