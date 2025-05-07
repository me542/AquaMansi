import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String stage; // Tree growth stage label (e.g., "Young Trees")
  final int count; // Number of trees in this stage
  final Color color; // Background color for avatar (if needed)
  final String imagePath; // Image path for the stage

  const ProgressCard({
    Key? key,
    required this.stage,
    required this.count,
    required this.color,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCA8DF4C2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stage image
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 16),
            // Stage name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF188097),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Tree count (unchanged)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 35,
                    color: Color(0xFF188097),
                    fontWeight: FontWeight.bold,
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
