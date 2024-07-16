import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/provider/symptoms_provider.dart';
import 'package:healther_mobile_app/screen/create_digital_prescription_screens.dart';
import 'package:healther_mobile_app/screen/patient_datails_screen.dart';
import 'package:healther_mobile_app/service/symptoms_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  bool isExpired = token != null ? JwtDecoder.isExpired(token) : true;
  runApp(
     MyApp(isLoggedIn: token != null && !isExpired),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CreateSymptomsService());

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return CreateSymptomsProvider();
          }),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
          home: const PatientDetailsScreen(),
        )
    );
  }
}
