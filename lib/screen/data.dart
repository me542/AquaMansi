import 'package:flutter/material.dart';
import 'package:aquamansi_frontend/widget/appbar.dart'; // Adjust this import path

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true, // Back arrow visible
        showMenuButton: false, // No menu button on Data screen
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the top
          children: [
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time')),
                      DataColumn(label: Text('Soil Moisture')),
                    ],
                    rows: [
                      DataRow(
                        selected: false, // Remove selection box
                        onSelectChanged: (_) {
                          _showPopUp(
                            context,
                            'Date: 2025-01-09\nTime: 10:00 AM\nSoil Moisture: 45%',
                          );
                        },
                        cells: const [
                          DataCell(Text('2025-01-09')),
                          DataCell(Text('10:00 AM')),
                          DataCell(Text('45%')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show a pop-up dialog with a table
  void _showPopUp(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Row Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(details),
              const SizedBox(height: 16), // Space between details and table
              Table(
                border: TableBorder.all(color: Colors.grey), // Add table borders
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.grey),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Tree', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Stages', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Moisture', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Tree1'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Young'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('45%'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Tree2'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Young'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('20%'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Tree3'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Matured'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('68%'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
