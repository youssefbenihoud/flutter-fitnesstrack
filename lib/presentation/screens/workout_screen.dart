import 'package:flutter/material.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutScreen({super.key, required this.workout});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _currentExerciseIndex = 0;

  void _nextExercise() {
    setState(() {
      if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
        _currentExerciseIndex++;
      } else {
        // Workout finished
        Navigator.of(context).pop(); // Go back to home screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.workout.exercises[_currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise: ${currentExercise.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Sets: ${currentExercise.sets}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Reps: ${currentExercise.reps}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Weight: ${currentExercise.weight}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextExercise,
                child: Text(
                  _currentExerciseIndex < widget.workout.exercises.length - 1
                      ? 'Next Exercise'
                      : 'Finish Workout',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
