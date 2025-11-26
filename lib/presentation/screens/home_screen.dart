import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/workout_bloc.dart';
import 'package:fittrack_app/presentation/widgets/workout_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutBloc>().add(LoadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutLoaded) {
            if (state.workouts.isEmpty) {
              return const Center(
                child: Text('No workouts yet. Start by creating one!'),
              );
            }
            return ListView.builder(
              itemCount: state.workouts.length,
              itemBuilder: (context, index) {
                final workout = state.workouts[index];
                return WorkoutCard(
                  workout: workout,
                  onDelete: () {
                    context.read<WorkoutBloc>().add(DeleteWorkout(workout));
                  },
                  onEdit: () {
                    // Navigate to edit workout screen
                  },
                );
              },
            );
          } else if (state is WorkoutError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create workout screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
