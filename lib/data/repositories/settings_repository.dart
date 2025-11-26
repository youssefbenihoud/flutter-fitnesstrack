import 'package:hive_flutter/hive_flutter.dart';
import 'package:fittrack_app/business_logic/models/settings.dart';
import 'package:fittrack_app/data/local/hive_boxes.dart';

class SettingsRepository {
  late Box<Settings> _settingsBox;

  Future<void> init() async {
    _settingsBox = await Hive.openBox<Settings>(HiveBoxes.settings);
    if (_settingsBox.isEmpty) {
      _settingsBox.add(Settings()); // Initialize with default settings
    }
  }

  Settings getSettings() {
    return _settingsBox.getAt(0)!; // Assuming only one settings object
  }

  Future<void> updateWeightUnit(WeightUnit weightUnit) async {
    final settings = getSettings();
    settings.weightUnit = weightUnit;
    await settings.save();
  }
}