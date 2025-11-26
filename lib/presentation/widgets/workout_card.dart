import 'package:flutter/material.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback? onTap; // Added onTap

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onDelete,
    required this.onEdit,
    this.onTap, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell( // Use InkWell for onTap
        onTap: onTap, // Assign onTap
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ...workout.exercises.map(
              (exercise) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                    '${exercise.name}: ${exercise.sets} sets of ${exercise.reps} reps at ${exercise.weight}'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
