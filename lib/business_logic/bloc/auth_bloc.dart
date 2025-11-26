import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fittrack_app/data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<Registered>(_onRegistered);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final bool isLoggedIn = _userRepository.isLoggedIn();
    if (isLoggedIn) {
      final String? username = _userRepository.getCurrentUsername();
      if (username != null) {
        emit(Authenticated(username));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.username));
  }

  Future<void> _onRegistered(Registered event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.username));
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _userRepository.logoutUser();
    emit(Unauthenticated());
  }
}
