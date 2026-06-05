import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionStorage {
  static const _planKey = 'subscription_plan_key';
  static const _priceKey = 'subscription_price_key';
  static const _paymentMethodKey = 'subscription_payment_method_key';
  static const _startedAtKey = 'subscription_started_at_key';

  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static Future<String?> getCurrentPlan() async {
    final prefs = await _prefs;
    return prefs.getString(_planKey);
  }

  static Future<double?> getCurrentPrice() async {
    final prefs = await _prefs;
    return prefs.getDouble(_priceKey);
  }

  static Future<String?> getCurrentPaymentMethod() async {
    final prefs = await _prefs;
    return prefs.getString(_paymentMethodKey);
  }

  static Future<DateTime?> getStartedAt() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_startedAtKey);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  static Future<void> subscribe({
    required String planName,
    required double price,
    required String paymentMethod,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(_planKey, planName);
    await prefs.setDouble(_priceKey, price);
    await prefs.setString(_paymentMethodKey, paymentMethod);
    await prefs.setString(_startedAtKey, DateTime.now().toIso8601String());
  }

  static Future<void> cancel() async {
    final prefs = await _prefs;
    await prefs.remove(_planKey);
    await prefs.remove(_priceKey);
    await prefs.remove(_paymentMethodKey);
    await prefs.remove(_startedAtKey);
  }
}