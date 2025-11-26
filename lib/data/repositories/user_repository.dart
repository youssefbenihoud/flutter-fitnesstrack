import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fittrack_app/business_logic/models/user.dart';

class UserRepository {
  late Box<User> _userBox;
  late SharedPreferences _prefs;

  static const String _loggedInKey = 'isLoggedIn';
  static const String _currentUsernameKey = 'currentUsername';

  Future<void> init() async {
    _userBox = await Hive.openBox<User>('users'); // A box for storing users
    _prefs = await SharedPreferences.getInstance();
  }

  Future<User?> registerUser(String username, String password) async {
    if (_userBox.containsKey(username)) {
      return null; // Username already exists
    }
    final newUser = User(username: username, password: password);
    await _userBox.put(username, newUser);
    return newUser;
  }

  Future<User?> loginUser(String username, String password) async {
    final user = _userBox.get(username);
    if (user != null && user.password == password) {
      await _prefs.setBool(_loggedInKey, true);
      await _prefs.setString(_currentUsernameKey, username);
      return user;
    }
    return null; // Invalid credentials
  }

  Future<void> logoutUser() async {
    await _prefs.setBool(_loggedInKey, false);
    await _prefs.remove(_currentUsernameKey);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_loggedInKey) ?? false;
  }

  String? getCurrentUsername() {
    return _prefs.getString(_currentUsernameKey);
  }
}
