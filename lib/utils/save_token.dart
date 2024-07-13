//
//
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefService{
//   static const _key = "access";
//
//   bool isTokenExpired(String token) {
//     return JwtDecoder.isExpired(token);
//   }
//   static Future<void> setAccessToken(String token) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_key, token);
//   }
//
//   static Future<String?> getAccessToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_key);
//   }
//
//   static Future<void> deleteAccessToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_key);
//   }
// }