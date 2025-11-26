import 'package:hive_flutter/hive_flutter.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';
import 'package:fittrack_app/data/local/hive_boxes.dart';

class WorkoutRepository {
  late Box<Workout> _workoutBox;

  Future<void> init() async {
    _workoutBox = await Hive.openBox<Workout>(HiveBoxes.workouts);
  }

  List<Workout> getWorkouts() {
    return _workoutBox.values.toList();
  }

  Future<void> addWorkout(Workout workout) async {
    await _workoutBox.add(workout);
  }

  Future<void> updateWorkout(Workout workout) async {
    await workout.save(); // HiveObject's save method updates the existing entry
  }

  Future<void> deleteWorkout(Workout workout) async {
    await workout.delete(); // HiveObject's delete method removes the entry
  }
}
