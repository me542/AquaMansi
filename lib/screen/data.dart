import 'package:flutter/material.dart';
import 'package:Aquamansi/widget/appbar.dart';
import 'package:Aquamansi/hive/hive.dart';
import 'dart:async';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  List<DataRow> dataRows = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _loadStoredData(); // Load stored Hive data on startup
    });
  }

  /// Load previously stored data from Hive
  Future<void> _loadStoredData() async {
    List<Map<String, String>> storedEntries = await HiveService.getData();  // Now returning List<Map<String, String>>
    List<DataRow> storedRows = storedEntries.map((entry) {
      // Assuming entry has keys like 'dateTime', 'sensorId', 'stage', 'soilMoisture'
      String dateTime = entry['dateTime'] ?? 'Unknown'; // Adjust based on your keys
      String sensorId = entry['sensorId'] ?? 'Unknown'; // Adjust based on your keys
      String stage = entry['stage'] ?? 'Unknown'; // Adjust based on your keys
      String soilMoisture = entry['soilMoisture'] ?? 'Unknown'; // Adjust based on your keys

      return DataRow(cells: [
        DataCell(Text(dateTime)), // Date & Time
        DataCell(Text(sensorId)), // Sensor ID
        DataCell(Text(stage)), // Stages
        DataCell(Text(soilMoisture)), // Soil Moisture
      ]);
    }).toList();

    if (mounted) {
      setState(() => dataRows = storedRows);
    }
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          Spacer(flex: dataRows.isNotEmpty ? 1 : 10),
          ElevatedButton(
            onPressed: _loadStoredData,
            child: const Text('Fetch Data'),
          ),
          const Expanded(child: Center()), // Added const for optimization
        ],
      ),
    );
  }
}