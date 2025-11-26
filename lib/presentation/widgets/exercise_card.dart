import 'package:flutter/material.dart';
import 'package:fittrack_app/business_logic/models/exercise.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<Exercise> onChanged;
  final VoidCallback onDelete;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late TextEditingController _nameController;
  late TextEditingController _setsController;
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise.name);
    _setsController = TextEditingController(text: widget.exercise.sets.toString());
    _repsController = TextEditingController(text: widget.exercise.reps.toString());
    _weightController = TextEditingController(text: widget.exercise.weight.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onChanged() {
    widget.onChanged(
      Exercise(
        name: _nameController.text,
        sets: int.tryParse(_setsController.text) ?? 0,
        reps: int.tryParse(_repsController.text) ?? 0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Exercise Name'), // Using themed InputDecoration
                    onChanged: (_) => _onChanged(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8.0), // Added spacing
            TextField(
              controller: _setsController,
              decoration: InputDecoration(labelText: 'Sets'), // Using themed InputDecoration
              keyboardType: TextInputType.number,
              onChanged: (_) => _onChanged(),
            ),
            const SizedBox(height: 8.0), // Added spacing
            TextField(
              controller: _repsController,
              decoration: InputDecoration(labelText: 'Reps'), // Using themed InputDecoration
              keyboardType: TextInputType.number,
              onChanged: (_) => _onChanged(),
            ),
            const SizedBox(height: 8.0), // Added spacing
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'), // Using themed InputDecoration
              keyboardType: TextInputType.number,
              onChanged: (_) => _onChanged(),
            ),
          ],
        ),
      ),
    );
  }
}