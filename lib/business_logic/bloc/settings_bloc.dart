import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fittrack_app/business_logic/models/settings.dart';
import 'package:fittrack_app/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc(this._settingsRepository) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateWeightUnit>(_onUpdateWeightUnit);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final settings = _settingsRepository.getSettings();
    emit(SettingsLoaded(settings));
  }

  Future<void> _onUpdateWeightUnit(
      UpdateWeightUnit event, Emitter<SettingsState> emit) async {
    await _settingsRepository.updateWeightUnit(event.weightUnit);
    final settings = _settingsRepository.getSettings();
    emit(SettingsLoaded(settings));
  }
}