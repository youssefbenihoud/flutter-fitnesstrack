import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/data/local/workout_adapter.dart';
import 'package:fittrack_app/data/repositories/settings_repository.dart';
import 'package:fittrack_app/data/repositories/workout_repository.dart';
import 'package:fittrack_app/data/repositories/user_repository.dart'; // Import UserRepository
import 'package:fittrack_app/business_logic/bloc/settings_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/workout_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/auth_bloc.dart'; // Import AuthBloc
import 'package:fittrack_app/presentation/screens/home_screen.dart';
import 'package:fittrack_app/presentation/screens/login_screen.dart'; // Import LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  final settingsRepository = SettingsRepository();
  await settingsRepository.init();
  final workoutRepository = WorkoutRepository();
  await workoutRepository.init();
  final userRepository = UserRepository(); // Initialize UserRepository
  await userRepository.init(); // Initialize UserRepository

  runApp(
    MultiRepositoryProvider( // Use MultiRepositoryProvider
      providers: [
        RepositoryProvider<SettingsRepository>(
          create: (context) => settingsRepository,
        ),
        RepositoryProvider<WorkoutRepository>(
          create: (context) => workoutRepository,
        ),
        RepositoryProvider<UserRepository>( // Provide UserRepository
          create: (context) => userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(settingsRepository),
          ),
          BlocProvider<WorkoutBloc>(
            create: (context) => WorkoutBloc(workoutRepository),
          ),
          BlocProvider<AuthBloc>( // Provide AuthBloc
            create: (context) => AuthBloc(userRepository)..add(AppStarted()), // Dispatch AppStarted
          ),
        ],
        child: const MyApp(),
      ),
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
        brightness: Brightness.light,
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          background: Colors.grey[100]!,
          onBackground: Colors.black87,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        useMaterial3: true,
      ),
      home: BlocBuilder<AuthBloc, AuthState>( // Listen to AuthState
        builder: (context, state) {
          if (state is Authenticated) {
            return const HomeScreen();
          } else if (state is Unauthenticated) {
            return const LoginScreen();
          }
          return const Center(child: CircularProgressIndicator()); // Loading state
        },
      ),
    );
  }
}