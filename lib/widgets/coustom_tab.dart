import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercisemodel.dart'; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomTab extends StatefulWidget {
  final Function() onExerciseAdded;

  const CustomTab({required this.onExerciseAdded, super.key});

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _reps = 0;
  int _sets = 0;
  int _weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Make Your Own Exercise',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _titleController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter a title for the exercise',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title for the exercise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberPicker(
                      label: 'Reps',
                      value: _reps,
                      onChanged: (value) {
                        setState(() {
                          _reps = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNumberPicker(
                      label: 'Sets',
                      value: _sets,
                      onChanged: (value) {
                        setState(() {
                          _sets = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: _buildNumberPicker(
                  label: 'Weight',
                  value: _weight,
                  onChanged: (value) {
                    setState(() {
                      _weight = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final box = await Hive.openBox<Exercise>('exercises');
                      final exercise = Exercise(
                        name: _titleController.text,
                        reps: _reps,
                        sets: _sets,
                        weight: _weight,
                      );
                      final today =
                          DateTime.now().toIso8601String().split('T').first;
                      await box.put(today, exercise);

                      _titleController.clear();
                      setState(() {
                        _reps = 0;
                        _sets = 0;
                        _weight = 0;
                      });

                      widget.onExerciseAdded();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildNumberPicker({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      child: NumberPicker(
        minValue: 0,
        maxValue: 100,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
