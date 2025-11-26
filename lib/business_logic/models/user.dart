import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password; // In a real app, store hashed passwords

  @HiveField(2)
  double? height; // in cm

  @HiveField(3)
  double? weight; // in kg

  @HiveField(4)
  String? fitnessGoals;

  User({
    required this.username,
    required this.password,
    this.height,
    this.weight,
    this.fitnessGoals,
  });
}