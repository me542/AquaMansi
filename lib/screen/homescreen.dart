import 'package:flutter/material.dart';
import '../widget/appbar.dart';
import '../widget/indicator.dart';
import '../widget/processcard.dart';
import '../widget/sensorsetup.dart';

void main() {
  runApp(const Homescreen());
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Declare a variable to hold the sensor counts for each stage
  Map<String, int> sensorCounts = {
    'Young': 0,
    'Juvenile': 0,
    'Mature': 0,
  };

  // Function to update the count for a specific stage
  void updateStageCount(String stage, {bool increment = true}) {
    setState(() {
      if (increment) {
        sensorCounts[stage] = sensorCounts[stage]! + 1;
      } else {
        if (sensorCounts[stage]! > 0) {
          sensorCounts[stage] = sensorCounts[stage]! - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(
          showBackArrow: false,
          showMenuButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                CircleLoadingIndicator(), // Circle Loading Indicator as a separate widget

                // ProgressCard for "Young" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Young',
                  count: sensorCounts['Young']!,
                  color: Colors.blue,
                  imagePath: 'asset/young.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Juvenile" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Juvenile',
                  count: sensorCounts['Juvenile']!,
                  color: Colors.blue,
                  imagePath: 'asset/juvenile.png', // Replace with your image
                ),
                const SizedBox(height: 16),
                // ProgressCard for "Matured" stage with its specific image
                ProgressCard(
                  percentage: 0,
                  stage: 'Mature',
                  count: sensorCounts['Mature']!,
                  color: Colors.blue,
                  imagePath: 'asset/mature.png', // Replace with your image
                ),
                // Add the Sensor Setup widget here
                const SizedBox(height: 16),
                Setup(updateStageCount: updateStageCount),  // Pass function to update counts
              ],
            ),
          ),
        ),
      ),
    );
  }
}
