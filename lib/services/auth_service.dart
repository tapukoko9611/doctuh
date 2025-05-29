import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _usersKey = 'users';
  static const String _loggedInUserEmailKey = 'loggedInUserEmail';

  Future<List<User>> _getStoredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      return User.decode(usersJson);
    }
    return [];
  }

  Future<void> _saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final String usersJson = User.encode(users);
    await prefs.setString(_usersKey, usersJson);
  }

  Future<bool> signUp(User newUser) async {
    final List<User> users = await _getStoredUsers();
    if (users.any((user) => user.email == newUser.email)) {
      return false;
    }
    users.add(newUser);
    await _saveUsers(users);
    return true;
  }

  Future<User?> login(String email, String password) async {
    final List<User> users = await _getStoredUsers();
    for (var user in users) {
      if ((user.email == email || (user.countryCode + user.mobileNumber) == email) && user.password == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_loggedInUserEmailKey, user.email); // Store logged in user's email
        return user;
      }
    }
    return null;
  }

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loggedInEmail = prefs.getString(_loggedInUserEmailKey);
    if (loggedInEmail != null) {
      final List<User> users = await _getStoredUsers();
      return users.firstWhere((user) => user.email == loggedInEmail, orElse: () => throw Exception('Logged in user not found...'));
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserEmailKey);
  }
}