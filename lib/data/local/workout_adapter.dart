import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fittrack_app/business_logic/models/exercise.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';
import 'package:fittrack_app/business_logic/models/settings.dart';
import 'package:fittrack_app/business_logic/models/user.dart'; // Import User model

Future<void> initHive() async {
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  } else {
    Hive.initFlutter();
  }

  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WeightUnitAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(UserAdapter()); // Register UserAdapter
}
