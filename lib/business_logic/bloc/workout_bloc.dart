import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fittrack_app/business_logic/models/workout.dart';
import 'package:fittrack_app/data/repositories/workout_repository.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _workoutRepository;

  WorkoutBloc(this._workoutRepository) : super(WorkoutInitial()) {
    on<LoadWorkouts>(_onLoadWorkouts);
    on<AddWorkout>(_onAddWorkout);
    on<UpdateWorkout>(_onUpdateWorkout);
    on<DeleteWorkout>(_onDeleteWorkout);
  }

  void _onLoadWorkouts(LoadWorkouts event, Emitter<WorkoutState> emit) {
    emit(WorkoutLoading());
    try {
      final workouts = _workoutRepository.getWorkouts();
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> _onAddWorkout(AddWorkout event, Emitter<WorkoutState> emit) async {
    await _workoutRepository.addWorkout(event.workout);
    add(LoadWorkouts()); // Reload workouts after adding
  }

  Future<void> _onUpdateWorkout(
      UpdateWorkout event, Emitter<WorkoutState> emit) async {
    await _workoutRepository.updateWorkout(event.workout);
    add(LoadWorkouts()); // Reload workouts after updating
  }

  Future<void> _onDeleteWorkout(
      DeleteWorkout event, Emitter<WorkoutState> emit) async {
    await _workoutRepository.deleteWorkout(event.workout);
    add(LoadWorkouts()); // Reload workouts after deleting
  }
}