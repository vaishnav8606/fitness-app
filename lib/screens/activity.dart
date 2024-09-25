import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/CreatePlan.dart';
import 'package:flutter_application_1/widgets/home_grid.dart';
import 'package:flutter_application_1/widgets/premade_tab.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'Activity',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            ActivityCard(
              title: 'Calories',
              value: '8000',
              unit: 'Unit',
              progress: 80,
              total: 100,
              icon: Icons.fire_hydrant,
              onReset: () {
                
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Createplan()),
                );
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Expanded(
              child: PremadeTab(),
            ),
          ],
        ),
      ),
    );
  }
}
