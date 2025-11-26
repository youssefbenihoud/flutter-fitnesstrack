part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;

  SettingsLoaded(this.settings);
}