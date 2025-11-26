import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/business_logic/bloc/settings_bloc.dart';
import 'package:fittrack_app/business_logic/models/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsInitial) {
            context.read<SettingsBloc>().add(LoadSettings());
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weight Unit:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<WeightUnit>(
                        value: WeightUnit.kg,
                        groupValue: state.settings.weightUnit,
                        onChanged: (WeightUnit? value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(UpdateWeightUnit(value));
                          }
                        },
                      ),
                      const Text('Kilograms (kg)'),
                      Radio<WeightUnit>(
                        value: WeightUnit.lbs,
                        groupValue: state.settings.weightUnit,
                        onChanged: (WeightUnit? value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(UpdateWeightUnit(value));
                          }
                        },
                      ),
                      const Text('Pounds (lbs)'),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Error loading settings.'));
        },
      ),
    );
  }
}
