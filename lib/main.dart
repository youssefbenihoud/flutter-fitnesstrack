import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/data/local/workout_adapter.dart';
import 'package:fittrack_app/data/repositories/settings_repository.dart';
import 'package:fittrack_app/data/repositories/workout_repository.dart';
import 'package:fittrack_app/business_logic/bloc/settings_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/workout_bloc.dart';
import 'package:fittrack_app/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  final settingsRepository = SettingsRepository();
  await settingsRepository.init();
  final workoutRepository = WorkoutRepository();
  await workoutRepository.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(settingsRepository),
        ),
        BlocProvider<WorkoutBloc>(
          create: (context) => WorkoutBloc(workoutRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Set HomeScreen as the home page
    );
  }
}