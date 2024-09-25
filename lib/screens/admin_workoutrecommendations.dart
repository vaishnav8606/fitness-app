import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin.dart';
class adminWorkoutRecommendationPage extends StatefulWidget {
  const adminWorkoutRecommendationPage({super.key});

  @override
  State<adminWorkoutRecommendationPage> createState() => _WorkoutRecommendationPageState();
}

class _WorkoutRecommendationPageState extends State<adminWorkoutRecommendationPage> {
  String selectedBodyPart = 'Full Body';
  String selectedDifficulty = 'Beginner';

  final bodyParts = ['Full Body', 'Chest', 'Back', 'Legs', 'Arms', 'Shoulders', 'Abs'];
  final difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];

  final Map<String, List<Map<String, String>>> recommendations = {
    'Full Body': [
      {'Beginner': 'Bodyweight Squats: 3 sets of 12-15 reps\nPush-Ups (Knee or Regular): 3 sets of 8-12 reps\nBent Over Dumbbell Rows: 3 sets of 10-12 reps\nPlank: 3 sets of 20-30 seconds\nGlute Bridges: 3 sets of 15 reps'},
      {'Intermediate': 'Goblet Squats: 3 sets of 12-15 reps\nIncline or Regular Push-Ups: 3 sets of 10-15 reps\nDumbbell Bench Press: 3 sets of 10-12 reps\nDumbbell Deadlifts: 3 sets of 10-12 reps\nRussian Twists: 3 sets of 20 reps'},
      {'Advanced': 'Barbell Back Squats: 4 sets of 6-10 reps\nBarbell Bench Press: 4 sets of 8-12 reps\nBarbell Deadlifts: 4 sets of 6-10 reps\nPull-Ups or Chin-Ups: 4 sets of 6-10 reps\nHanging Leg Raises: 4 sets of 12-15 reps'}
    ],
    'Chest': [
      {'Beginner': 'Incline Push-Ups: 3 sets of 10-15 reps\nDumbbell Bench Press: 3 sets of 8-12 reps\nChest Flyes: 3 sets of 12-15 reps'},
      {'Intermediate': 'Flat Bench Press: 3 sets of 8-12 reps\nDumbbell Pullover: 3 sets of 10-12 reps\nCable Crossovers: 3 sets of 12-15 reps'},
      {'Advanced': 'Barbell Bench Press: 4 sets of 6-10 reps\nIncline Dumbbell Press: 4 sets of 8-12 reps\nChest Dips: 4 sets of 8-12 reps\nPec Deck Machine: 4 sets of 10-15 reps'}
    ],
    'Back': [
      {'Beginner': 'Dumbbell Rows: 3 sets of 10-15 reps\nLat Pulldowns: 3 sets of 12-15 reps\nSeated Rows: 3 sets of 12 reps'},
      {'Intermediate': 'Pull-Ups: 3 sets of 8-12 reps\nSingle Arm Dumbbell Rows: 3 sets of 10-12 reps\nT-Bar Rows: 3 sets of 10-12 reps'},
      {'Advanced': 'Deadlifts: 4 sets of 6-10 reps\nBarbell Rows: 4 sets of 8-12 reps\nLat Pulldowns: 4 sets of 10-12 reps\nPull-Ups: 4 sets of 8-12 reps'}
    ],
    'Legs': [
      {'Beginner': 'Bodyweight Squats: 3 sets of 12-15 reps\nLunges: 3 sets of 10-12 reps per leg\nGlute Bridges: 3 sets of 15 reps'},
      {'Intermediate': 'Leg Press: 3 sets of 10-15 reps\nDumbbell Lunges: 3 sets of 10-12 reps per leg\nLeg Curls: 3 sets of 12-15 reps'},
      {'Advanced': 'Barbell Squats: 4 sets of 6-10 reps\nDeadlifts: 4 sets of 6-10 reps\nLeg Press: 4 sets of 10-12 reps\nWalking Lunges: 4 sets of 12-15 reps per leg'}
    ],
    'Arms': [
      {'Beginner': 'Bicep Curls: 3 sets of 12-15 reps\nTricep Dips (Bench): 3 sets of 10-12 reps\nHammer Curls: 3 sets of 12-15 reps'},
      {'Intermediate': 'Barbell Curls: 3 sets of 10-12 reps\nTricep Overhead Extension: 3 sets of 10-12 reps\nConcentration Curls: 3 sets of 12-15 reps'},
      {'Advanced': 'Preacher Curls: 4 sets of 8-12 reps\nSkull Crushers: 4 sets of 8-12 reps\nCable Bicep Curls: 4 sets of 10-12 reps\nDips: 4 sets of 8-12 reps'}
    ],
    'Shoulders': [
      {'Beginner': 'Dumbbell Shoulder Press: 3 sets of 10-15 reps\nLateral Raises: 3 sets of 12-15 reps\nFront Raises: 3 sets of 12-15 reps'},
      {'Intermediate': 'Barbell Shoulder Press: 3 sets of 8-12 reps\nArnold Press: 3 sets of 10-12 reps\nFace Pulls: 3 sets of 12-15 reps'},
      {'Advanced': 'Military Press: 4 sets of 6-10 reps\nUpright Rows: 4 sets of 8-12 reps\nDumbbell Lateral Raises: 4 sets of 12-15 reps\nRear Delt Flyes: 4 sets of 12-15 reps'}
    ],
    'Abs': [
      {'Beginner': 'Crunches: 3 sets of 15-20 reps\nLeg Raises: 3 sets of 12-15 reps\nPlank: 3 sets of 20-30 seconds'},
      {'Intermediate': 'Bicycle Crunches: 3 sets of 15-20 reps\nHanging Leg Raises: 3 sets of 12-15 reps\nRussian Twists: 3 sets of 20 reps'},
      {'Advanced': 'V-Ups: 4 sets of 12-15 reps\nToe Touches: 4 sets of 15-20 reps\nCable Woodchoppers: 4 sets of 12-15 reps per side'}
    ],
  };

  @override
  Widget build(BuildContext context) {
    final recommendation = recommendations[selectedBodyPart]!
        .firstWhere((element) => element.keys.first == selectedDifficulty)
        .values
        .first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Recommendations'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(recommendations: recommendations),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Body Part',
                border: OutlineInputBorder(),
              ),
              value: selectedBodyPart,
              items: bodyParts.map((String bodyPart) {
                return DropdownMenuItem<String>(
                  value: bodyPart,
                  child: Text(bodyPart),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedBodyPart = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Difficulty Level',
                border: OutlineInputBorder(),
              ),
              value: selectedDifficulty,
              items: difficultyLevels.map((String difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedDifficulty = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: recommendation.split('\n').map((exercise) {
                  return ListTile(
                    title: Text(exercise),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
