class RegisteredUsersManager {
  List<Map<String, String>> _registeredUsers = [];

  void addUser(Map<String, String> newUser) {
    _registeredUsers.add(newUser);
  }

  bool isUserRegistered(String email, String password) {
    return _registeredUsers.any((user) =>
    user['email'] == email && user['password'] == password);
  }
}

// Singleton instance of RegisteredUsersManager
final registeredUsersManager = RegisteredUsersManager();
