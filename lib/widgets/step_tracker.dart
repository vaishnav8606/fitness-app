import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepTracker extends StatefulWidget {
  final Function(int steps, double distance) onStepUpdate;

  const StepTracker({super.key, required this.onStepUpdate});

  @override
  _StepTrackerState createState() => _StepTrackerState();
}

class _StepTrackerState extends State<StepTracker> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;
  double _distance = 0.0;
  static const double _stepLength = 0.762; 

  @override
  void initState() {
    super.initState();
    _startStepTracking();
  }

  void _startStepTracking() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    print('New step count: ${event.steps}'); // Debugging step count

    setState(() {
      _steps = event.steps;
      _distance = _calculateDistance(_steps);
      widget.onStepUpdate(_steps, _distance);
    });
  }

  double _calculateDistance(int steps) {
    return (steps * _stepLength) / 1000; 
  }

  void _onStepCountError(error) {
    print('Step count error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
