import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final double progress;
  final String value;
  final String unit;
  final double total;
  final IconData icon;
  final VoidCallback onReset;

  const ActivityCard({
    Key? key,
    required this.title,
    required this.progress,
    required this.value,
    required this.unit,
    required this.total,
    required this.icon,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress / total,
              backgroundColor: Colors.grey[700],
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              '$value / $total $unit',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onReset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
