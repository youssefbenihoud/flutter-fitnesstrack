part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String username;

  LoggedIn(this.username);
}

class Registered extends AuthEvent {
  final String username;

  Registered(this.username);
}

class LoggedOut extends AuthEvent {}