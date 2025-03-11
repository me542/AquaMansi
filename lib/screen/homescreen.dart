import 'package:flutter/material.dart';
import '../widget/appbar.dart';
import '../widget/indicator.dart';
import '../widget/processcard.dart';
import '../widget/sensorsetup.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Map<String, int> sensorCounts = {
    'Young': 0,
    'Juvenile': 0,
    'Mature': 0,
  };

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
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: false,
        showMenuButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleLoadingIndicator(),
              ProgressCard(
                percentage: 0,
                stage: 'Young',
                count: sensorCounts['Young']!,
                color: const Color(0xFF188097),
                imagePath: 'asset/young.png',
              ),
              const SizedBox(height: 16),
              ProgressCard(
                percentage: 0,
                stage: 'Juvenile',
                count: sensorCounts['Juvenile']!,
                color: const Color(0xFF188097),
                imagePath: 'asset/juvenile.png',
              ),
              const SizedBox(height: 16),
              ProgressCard(
                percentage: 0,
                stage: 'Mature',
                count: sensorCounts['Mature']!,
                color: const Color(0xFF188097),
                imagePath: 'asset/mature.png',
              ),
              const SizedBox(height: 16),
              Setup(updateStageCount: updateStageCount),
            ],
          ),
        ),
      ),
    );
  }
}
