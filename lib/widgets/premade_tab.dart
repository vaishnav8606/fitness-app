import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercisemodel.dart'; 
import 'package:hive_flutter/hive_flutter.dart';

class PremadeTab extends StatelessWidget {
  const PremadeTab({super.key});

  void _editExercise(BuildContext context, Box<Exercise> box, int index) {
    final exercise = box.getAt(index);

    if (exercise != null) {
      TextEditingController nameController = TextEditingController(text: exercise.name);
      TextEditingController repsController = TextEditingController(text: exercise.reps.toString());
      TextEditingController setsController = TextEditingController(text: exercise.sets.toString());
      TextEditingController weightController = TextEditingController(text: exercise.weight.toString());

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Exercise'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  controller: repsController,
                  decoration: const InputDecoration(labelText: 'Reps'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: setsController,
                  decoration: const InputDecoration(labelText: 'Sets'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  exercise.name = nameController.text;
                  exercise.reps = int.parse(repsController.text);
                  exercise.sets = int.parse(setsController.text);
                  exercise.weight = int.parse(weightController.text);

                  box.putAt(index, exercise);

                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteExercise(Box<Exercise> box, int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Exercise>('exercises').listenable(),
      builder: (context, Box<Exercise> box, _) {
        final exercises = box.values.toList();

        return exercises.isEmpty
            ? const Center(child: Text('No exercises added', style: TextStyle(color: Colors.white)))
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(exercise.name),
                      subtitle: Text(
                          'Reps: ${exercise.reps} | Sets: ${exercise.sets} | Weight: ${exercise.weight} kg'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editExercise(context, box, index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteExercise(box, index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
