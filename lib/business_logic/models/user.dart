import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4) // Use the next available typeId
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password; // In a real app, store hashed passwords

  User({required this.username, required this.password});
}