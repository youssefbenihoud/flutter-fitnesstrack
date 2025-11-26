import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/workout_bloc.dart';
import 'package:fittrack_app/business_logic/models/exercise.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';
import 'package:fittrack_app/presentation/widgets/exercise_card.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final _workoutNameController = TextEditingController();
  final List<Exercise> _exercises = [];

  void _addExercise() {
    setState(() {
      _exercises.add(
        Exercise(name: '', sets: 0, reps: 0, weight: 0.0),
      );
    });
  }

  void _saveWorkout() {
    if (_workoutNameController.text.isEmpty || _exercises.isEmpty) {
      // Show error or snackbar
      return;
    }

    // Ensure all exercises have valid data
    for (var exercise in _exercises) {
      if (exercise.name.isEmpty || exercise.sets <= 0 || exercise.reps <= 0) {
        // Show error or snackbar
        return;
      }
    }

    final newWorkout = Workout(
      name: _workoutNameController.text,
      exercises: _exercises,
    );
    context.read<WorkoutBloc>().add(AddWorkout(newWorkout));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return ExerciseCard(
                    exercise: exercise,
                    onChanged: (updatedExercise) {
                      setState(() {
                        _exercises[index] = updatedExercise;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        _exercises.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addExercise,
              child: const Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
