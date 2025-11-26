import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fittrack_app/data/repositories/user_repository.dart';
import 'package:fittrack_app/business_logic/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalsController = TextEditingController();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    setState(() {
      _currentUser = userRepository.currentUser;
      if (_currentUser != null) {
        _heightController.text = _currentUser!.height?.toString() ?? '';
        _weightController.text = _currentUser!.weight?.toString() ?? '';
        _goalsController.text = _currentUser!.fitnessGoals ?? '';
      }
    });
  }

  Future<void> _saveProfile() async {
    if (_currentUser == null) return;

    final userRepository = RepositoryProvider.of<UserRepository>(context);
    await userRepository.updateUserProfile(
      username: _currentUser!.username,
      height: double.tryParse(_heightController.text),
      weight: double.tryParse(_weightController.text),
      fitnessGoals: _goalsController.text.isEmpty ? null : _goalsController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: Text('User not logged in or profile not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ${_currentUser!.username}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                hintText: 'e.g., 175',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                hintText: 'e.g., 70.5',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _goalsController,
              decoration: const InputDecoration(
                labelText: 'Fitness Goals',
                hintText: 'e.g., Build muscle, Lose weight, Run a marathon',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // In a real app, this would be handled by AuthBloc.
                  // For now, it will simply log out.
                  // context.read<AuthBloc>().add(LoggedOut());
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile (Save button above)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
