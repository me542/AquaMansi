import 'package:flutter/material.dart';
import 'package:Aquamansi/widget/appbar.dart';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  late WebSocketChannel channel;
  List<DataRow> dataRows = [];
  List<Map<String, String>> sensorDetails = []; // Holds dynamic sensor data
  String executionData = '';
  String sensorData = '';
  bool isConnected = false;  // To track connection status

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  // Function to establish a connection to WebSocket and start auto-fetch
  void connectToWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.100:81')); // Replace with your ESP8266 IP address
    channel.stream.listen(
          (message) {
        handleWebSocketMessage(message);
      },
      onDone: () {
        setState(() {
          isConnected = false;
        });
      },
      onError: (error) {
        print('Error in WebSocket connection: $error');
      },
    );
    setState(() {
      isConnected = true;
    });
    startAutoFetch();
  }

  void startAutoFetch() {
    if (isConnected) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        fetchData();
      });
    }
  }

  void fetchData() {
    if (isConnected) {
      channel.sink.add('GET_DATA');  // Send request to ESP8266 to fetch data
    }
  }

  @override
  void dispose() {
    channel.sink.close();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Day')),
                    DataColumn(label: Text('Date')),
                  ],
                  rows: dataRows.map((dataRow) {
                    return DataRow(
                      cells: dataRow.cells,
                      onSelectChanged: (selected) {
                        if (selected != null && selected) {
                          _showCountOfExecution(context, dataRow);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle received data
  void handleWebSocketMessage(String message) {
    try {
      print("Received message: $message");

      // Check for the expected data format
      if (message.contains('Data:')) {
        setState(() {
          // Assuming the message is structured with tables, split the message appropriately
          List<String> lines = message.split('\n');
          if (lines.length > 3) {
            executionData = lines[1]; // Adjust based on actual format
            sensorData = lines[3]; // Adjust based on actual format

            // Dynamically update the DataTable rows with the Day and Date values from the fetched data
            dataRows = List.generate(
              lines.length > 1 ? lines.length - 2 : 0,
                  (index) {
                var line = lines[index + 2]; // Skip header and execution data lines
                var parts = line.split(','); // Split by comma (Day, Date)
                return DataRow(cells: [
                  DataCell(Text(parts[0])), // Day
                  DataCell(Text(parts[1])), // Date
                ]);
              },
            );

            // Parse sensor data (example format)
            sensorDetails = [
              {
                'sensor': 'Sensor 1', // Replace with dynamic data
                'stage': 'Youth', // Replace with dynamic data
                'moistureLevel': '20%', // Replace with dynamic data
              },
              {
                'sensor': 'Sensor 2', // Replace with dynamic data
                'stage': 'Maturity', // Replace with dynamic data
                'moistureLevel': '30%', // Replace with dynamic data
              },
            ];
          }
        });
      } else {
        throw FormatException('Unexpected data format');
      }
    } catch (e) {
      print("Error while parsing message: $e");
    }
  }

  void _showCountOfExecution(BuildContext context, DataRow selectedDataRow) {
    // Extract the data you need for the dialog from the selected row
    String countOfExecution = executionData;  // Replace with dynamic data
    String time = ''; // Replace with dynamic data
    String moistureLevel = ''; // Replace with dynamic data

    // Pass this data to the next dialog to show sensor details
    _showSensorDetail(context, countOfExecution, time, moistureLevel);
  }

  void _showSensorDetail(BuildContext context, String countOfExecution, String time, String moistureLevel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sensor Detail'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Colors.grey),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Sensor', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Stages', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Moisture Level', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Loop through sensor details dynamically
                  ...sensorDetails.map((sensorDetail) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(sensorDetail['sensor'] ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(sensorDetail['stage'] ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(sensorDetail['moistureLevel'] ?? ''),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
