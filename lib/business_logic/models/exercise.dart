import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 0)
class Exercise extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int sets;

  @HiveField(2)
  late int reps;

  @HiveField(3)
  late double weight; // in kg or lbs

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}