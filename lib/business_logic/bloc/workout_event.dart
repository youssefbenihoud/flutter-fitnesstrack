part of 'workout_bloc.dart';

@immutable
sealed class WorkoutEvent {}

class LoadWorkouts extends WorkoutEvent {}

class AddWorkout extends WorkoutEvent {
  final Workout workout;

  AddWorkout(this.workout);
}

class UpdateWorkout extends WorkoutEvent {
  final Workout workout;

  UpdateWorkout(this.workout);
}

class DeleteWorkout extends WorkoutEvent {
  final Workout workout;

  DeleteWorkout(this.workout);
}