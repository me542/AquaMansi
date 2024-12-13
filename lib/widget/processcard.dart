import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int percentage; // Percentage of completion
  final String stage; // Growth stage (e.g., Young, Juvenile, Matured)
  final int count; // Number of trees in this stage
  final Color color; // Color for the progress bar
  final String imagePath; // Path to the image for this stage

  const ProgressCard({
    Key? key,
    required this.percentage,
    required this.stage,
    required this.count,
    required this.color,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4CECAE),
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4), // Shadow effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display image instead of an icon
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(imagePath), // Image for the stage
            ),
            const SizedBox(width: 16),
            // Text and progress indicator section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$percentage% Soil Level',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    color: color,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Count and stage text
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stage,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
