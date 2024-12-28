import 'package:flutter/material.dart';

class TimeCycle extends StatelessWidget {
  final int hours;
  final VoidCallback incrementHours;
  final VoidCallback decrementHours;

  const TimeCycle({
    super.key,
    required this.hours,
    required this.incrementHours,
    required this.decrementHours,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Irrigation Time Cycle',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: decrementHours,
              icon: const Icon(Icons.remove),
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$hours Hours',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: incrementHours,
              icon: const Icon(Icons.add),
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}
