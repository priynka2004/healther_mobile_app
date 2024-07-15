import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const _key = "access";

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<void> setAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> deleteAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveData({
    required String mobileNumber,
    required String firstName,
    required String age,
    required String gender,
    required DateTime dob,
    required DateTime spo2,
    required DateTime pulseRate,
    required DateTime rbs,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', mobileNumber);
    await prefs.setString('firstName', firstName);
    await prefs.setString('age', age);
    await prefs.setString('gender', gender);
    await prefs.setString('dob',dob.toIso8601String());
    await prefs.setString('spo2',spo2.toString());
    await prefs.setString('pulseRate',pulseRate.toString());
    await prefs.setString('rbs', rbs.toString());
  }

  Future<Map<String, String?>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'mobileNumber': prefs.getString('mobileNumber'),
      'firstName': prefs.getString('firstName'),
      'age': prefs.getString('age'),
      'gender': prefs.getString('gender'),
      'dob': prefs.getString('dob'),
      'spo2': prefs.getString('spo2'),
      'pulseRate': prefs.getString('pulseRate'),
      'rbs': prefs.getString('rbs'),
    };
  }
}
