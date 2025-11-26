import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
enum WeightUnit {
  @HiveField(0)
  kg,
  @HiveField(1)
  lbs,
}

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  late WeightUnit weightUnit;

  Settings({
    this.weightUnit = WeightUnit.kg, // Default to kilograms
  });
}
