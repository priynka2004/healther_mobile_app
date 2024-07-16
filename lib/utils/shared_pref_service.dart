import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const _key = "access";
  static String time = "times";
  static const String timeKey = 'timePeriod';

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static const String symptomNameKey = 'symptomName';
  static const String timePeriodKey = 'timePeriod';
  static const String durationKey = 'duration';

  static Future<void> setSymptomName(String symptomName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(symptomNameKey, symptomName);
  }

  static Future<String?> getSymptomName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(symptomNameKey);
  }

  static Future<void> setTimePeriod(String timePeriod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(timePeriodKey, timePeriod);
  }

  static Future<String?> getTimePeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(timePeriodKey);
  }

  static Future<void> setDuration(String duration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(durationKey, duration);
  }

  static Future<String?> getDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(durationKey);
  }

  // static Future<bool> setTimePeriod(String Times) async{
  //   SharedPreferences prefs= await SharedPreferences.getInstance();
  //   return await prefs.setString(time, Times);
  // }
  //
  // static Future<String?> getTimePeriod()async{
  //   SharedPreferences prefs= await SharedPreferences.getInstance();
  //   return prefs.getString(time);
  // }


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
