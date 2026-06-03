import 'package:shared_preferences/shared_preferences.dart';
import '../models/appointment_model.dart';
import 'auth_storage.dart';

class AppointmentStorage {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static String _keyForEmail(String email) =>
      'appointments_${email.toLowerCase()}';

  static Future<List<AppointmentModel>> getAppointmentsForCurrentUser() async {
    final user = await AuthStorage.getCurrentUser();
    if (user == null) return [];

    final prefs = await _prefs;
    final raw = prefs.getStringList(_keyForEmail(user.email)) ?? [];
    return raw.map((e) => AppointmentModel.fromJson(e)).toList();
  }

  static Future<void> addAppointment(AppointmentModel appointment) async {
    final user = await AuthStorage.getCurrentUser();
    if (user == null) return;

    final prefs = await _prefs;
    final key = _keyForEmail(user.email);

    final raw = prefs.getStringList(key) ?? [];
    final list = raw.map((e) => AppointmentModel.fromJson(e)).toList();

    list.add(appointment);
    await prefs.setStringList(key, list.map((e) => e.toJson()).toList());
  }
}