import 'package:flutter/material.dart';

class CountExecute extends StatelessWidget {
  final int hours2;
  final VoidCallback incrementHours2;
  final VoidCallback decrementHours2;

  const CountExecute({
    super.key,
    required this.hours2,
    required this.incrementHours2,
    required this.decrementHours2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Number of Cycles',
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
              onPressed: decrementHours2,
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
                '$hours2 Times',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: incrementHours2,
              icon: const Icon(Icons.add),
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}
