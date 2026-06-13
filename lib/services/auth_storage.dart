import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';

/*
 * Classe responsável pelo gerenciamento da autenticação.
 *
 * Controla cadastro, login, logout, informações do usuário,
 * exibição da introdução inicial e armazenamento local dos dados.
 */

class AuthStorage {
  static const _usersKey = 'users_key';
  static const _currentUserKey = 'current_user_key';
  static const _introSeenKey = 'intro_seen_key';

  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static Future<bool> getIntroSeen() async {
    final prefs = await _prefs;
    return prefs.getBool(_introSeenKey) ?? false;
  }

  static Future<void> setIntroSeen(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_introSeenKey, value);
  }

  static Future<List<AppUser>> getUsers() async {
    final prefs = await _prefs;
    final raw = prefs.getStringList(_usersKey) ?? [];
    return raw.map((e) => AppUser.fromJson(e)).toList();
  }

  static Future<void> saveUsers(List<AppUser> users) async {
    final prefs = await _prefs;
    await prefs.setStringList(_usersKey, users.map((e) => e.toJson()).toList());
  }

  static Future<AppUser?> getCurrentUser() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_currentUserKey);
    if (raw == null) return null;
    return AppUser.fromJson(raw);
  }

  static Future<bool> registerUser(AppUser user) async {
    final users = await getUsers();

    final exists = users.any(
      (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );
    if (exists) return false;

    users.add(user);
    await saveUsers(users);
    await _setCurrentUser(user);
    return true;
  }

  static Future<bool> login(String email, String password) async {
    final users = await getUsers();

    final found = users.where(
      (u) =>
          u.email.toLowerCase() == email.toLowerCase() &&
          u.password == password,
    );

    if (found.isEmpty) return false;

    await _setCurrentUser(found.first);
    return true;
  }

  static Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_currentUserKey);
  }

  static Future<void> updateAvatar(String avatarBase64) async {
    final current = await getCurrentUser();
    if (current == null) return;

    final updated = current.copyWith(avatarBase64: avatarBase64);
    await _saveCurrentUserAndList(updated);
  }

  static Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final current = await getCurrentUser();
    if (current == null) return;

    final updated = current.copyWith(
      name: name,
      phone: phone,
    );

    await _saveCurrentUserAndList(updated);
  }

  static Future<void> _saveCurrentUserAndList(AppUser updated) async {
    final prefs = await _prefs;
    await prefs.setString(_currentUserKey, updated.toJson());

    final users = await getUsers();
    final index = users.indexWhere((u) => u.email == updated.email);
    if (index != -1) {
      users[index] = updated;
      await saveUsers(users);
    }
  }

  static Future<void> _setCurrentUser(AppUser user) async {
    final prefs = await _prefs;
    await prefs.setString(_currentUserKey, user.toJson());
  }
}
