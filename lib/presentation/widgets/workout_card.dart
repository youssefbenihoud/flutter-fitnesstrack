import 'package:flutter/material.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onDelete,
    required this.onEdit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card styling is now managed by CardTheme in main.dart
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Use margin from theme but override if needed
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10), // Match Card's border radius
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              ...workout.exercises.map(
                (exercise) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    '${exercise.name}: ${exercise.sets} sets of ${exercise.reps} reps at ${exercise.weight}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}