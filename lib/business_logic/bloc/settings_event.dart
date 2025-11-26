part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateWeightUnit extends SettingsEvent {
  final WeightUnit weightUnit;

  UpdateWeightUnit(this.weightUnit);
}