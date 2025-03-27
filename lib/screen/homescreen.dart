import 'package:flutter/material.dart';
import 'package:Aquamansi/hive/hive.dart'; // Import HiveService
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

  @override
  void initState() {
    super.initState();
    _loadStageCounts();
  }

  /// Load stage counts from Hive when the app starts
  Future<void> _loadStageCounts() async {
    await HiveService.init(); // Ensure Hive is initialized
    setState(() {
      sensorCounts = {
        'Young': HiveService.getStageCount('Young'),
        'Juvenile': HiveService.getStageCount('Juvenile'),
        'Mature': HiveService.getStageCount('Mature'),
      };
    });
    print('Loaded stage counts: $sensorCounts');
  }

  /// Update stage count and save it to Hive
  void updateStageCount(String stage, {bool increment = true}) async {
    setState(() {
      if (increment) {
        sensorCounts[stage] = sensorCounts[stage]! + 1;
      } else {
        if (sensorCounts[stage]! > 0) {
          sensorCounts[stage] = sensorCounts[stage]! - 1;
        }
      }
    });

    await HiveService.updateStageCount(stage, increment: increment);
    print('Updated stage "$stage" count: ${sensorCounts[stage]}');
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
