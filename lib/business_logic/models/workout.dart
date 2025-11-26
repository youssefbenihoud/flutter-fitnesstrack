import 'package:hive/hive.dart';
import 'package:fittrack_app/business_logic/models/exercise.dart';

part 'workout.g.dart';

@HiveType(typeId: 1)
class Workout extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late List<Exercise> exercises;

  Workout({
    required this.name,
    required this.exercises,
  });
}