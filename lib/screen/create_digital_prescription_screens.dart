import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/screen/create_digital_presscription_screen.dart';
import 'package:healther_mobile_app/screen/sx&dx_screen.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healther_mobile_app/bottom_sheet/fever_affiramtions_sheet.dart';

class CreateDigitalPrescriptionScreens extends StatefulWidget {
  const CreateDigitalPrescriptionScreens({this.symptoms, super.key});
  final String? symptoms;

  @override
  State<CreateDigitalPrescriptionScreens> createState() =>
      _CreateDigitalPrescriptionScreensState();
}

class _CreateDigitalPrescriptionScreensState
    extends State<CreateDigitalPrescriptionScreens> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _updateSearchField(String text) {
    setState(() {
      searchController.text = text;
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length),
      );
    });

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FeverAffirmationsSheet(symptomName: text);
      },
    );
  }

  Future<void> _saveToSharedPreferences(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedValue', value);
  }

  void _onSubmit() {
    _saveToSharedPreferences(searchController.text).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SxAndDxScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leadingWidth: 30,
          title: Text(
            AppText.digitalPrescription,
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.25,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          backgroundColor: const Color(0xFFE1F9F2),
          actions: [
            IconButton(
              onPressed: _toggleDrawer,
              icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
            ),
          ],
        ),
        endDrawer: SizedBox(
          height: 600,
          child: Drawer(
            width: 320,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.64,
                    child: Material(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      elevation: 6,
                      shadowColor: const Color(0xffFFFFFF),
                      color: const Color(0xffFFFFFF),
                      surfaceTintColor: const Color(0xffFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vitals',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff0C091F)),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff5351C7)),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff5351C7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 4),
                                    height: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SpO2',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/Vector (4).png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '97',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BP',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/Vector (5).png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '80/120',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Heart rate',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/Vector (6).png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '80',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BG',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/droplet-outline.png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '150',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(right: 152),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 75,
                                      padding: const EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xffF5F5F5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ht',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff413D56),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Center(
                                            child: Image.asset(
                                                "assets/homeimages/Vector (7).png"),
                                          ),
                                          const SizedBox(height: 4),
                                          Center(
                                            child: Text(
                                              '160',
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff0C091F),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Container(
                                      height: 75,
                                      padding: const EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xffF5F5F5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Wt',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff413D56),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Center(
                                            child: Image.asset(
                                                "assets/homeimages/Vector (8).png"),
                                          ),
                                          const SizedBox(height: 4),
                                          Center(
                                            child: Text(
                                              '60',
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff0C091F),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.06),
                  Material(
                    elevation: 8,
                    shadowColor: const Color(0xFFFFFFFF),
                    surfaceTintColor: const Color(0xFFFFFFFF),
                    color: const Color(0xFFFFFFFF),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Past History',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff5351C7),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff5351C7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Family History',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: width,
                            height: 40,
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Text(
                              'Asthma, Hypertension',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff0C091F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Medical Procedures',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff868686),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: width,
                            height: 40,
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Text(
                              'Heart Surgery',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff0C091F),
                              ),
                            ),
                            // onTap: () {},
                            // contentPadding: const EdgeInsets.symmetric(
                            //     horizontal: 10.0, vertical: 2.0),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Medication',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff868686),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: width,
                            height: 40,
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Text(
                              'Dolo - 650, Paracetomol',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff0C091F),
                              ),
                            ),
                            // onTap: () {},
                            // contentPadding: const EdgeInsets.symmetric(
                            //     horizontal: 8.0, vertical: 2.0),
                          ),
                          SizedBox(height: height * 0.04),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Allergies - ',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff868686),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pollen, Sunlight',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phobias/Fears - ',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff868686),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pollen, Sunlight',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Symptoms & Diagnosis',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor),
              ),
              const Divider(
                color: AppColors.blackColor,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SxAndDxScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (value) => _onSubmit(),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF8F7FC),
                      border: InputBorder.none,
                      hintText: 'Search by symptoms or diagnosis',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      icon: Icon(Icons.search, color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const InkWell(
                child: Text(
                  "Frequently searched Symptoms",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff767676),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => _updateSearchField("Shallow breathing"),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Shallow breathing",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff0C091F)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                       _updateSearchField("Fever");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white1Color,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Fever",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => _updateSearchField("Sweating & chills"),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white1Color,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Sweating & chills",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: () => _updateSearchField("Headache"),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white1Color,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Headache",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () => _updateSearchField("Muscle pain"),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.white1Color,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Muscle pain",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:healther_mobile_app/bottom_sheet/fever_affiramtions_sheet.dart';
// import 'package:healther_mobile_app/screen/sx&dx_screen.dart';
// import 'package:healther_mobile_app/utils/app_colors.dart';
// import 'package:healther_mobile_app/utils/string_const.dart';
//
// class CreateDigitalPrescriptionScreens extends StatefulWidget {
//   const CreateDigitalPrescriptionScreens({this.symptoms, Key? key}) : super(key: key);
//   final String? symptoms;
//
//   @override
//   State<CreateDigitalPrescriptionScreens> createState() =>
//       _CreateDigitalPrescriptionScreensState();
// }
//
// class _CreateDigitalPrescriptionScreensState
//     extends State<CreateDigitalPrescriptionScreens> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController searchController = TextEditingController();
//   bool _isDrawerOpen = false;
//
//   void _toggleDrawer() {
//     if (_scaffoldKey.currentState!.isEndDrawerOpen) {
//       Navigator.of(context).pop();
//     } else {
//       _scaffoldKey.currentState!.openEndDrawer();
//     }
//     setState(() {
//       _isDrawerOpen = !_isDrawerOpen;
//     });
//   }
//
//   void _updateSearchField(String text) {
//     setState(() {
//       searchController.text = text;
//       searchController.selection = TextSelection.fromPosition(
//         TextPosition(offset: searchController.text.length),
//       );
//     });
//
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return FeverAffirmationsSheet(symptomName: text);
//       },
//     );
//   }
//
//   Future<void> _saveToSharedPreferences(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('savedValue', value);
//   }
//
//   void _onSubmit() {
//     _saveToSharedPreferences(searchController.text).then((_) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const SxAndDxScreen(),
//         ),
//       );
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedValue();
//   }
//
//   Future<void> _loadSavedValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedValue = prefs.getString('savedValue');
//     if (savedValue != null) {
//       setState(() {
//         searchController.text = savedValue;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           leadingWidth: 30,
//           title: Text(
//             AppText.digitalPrescription,
//             style: GoogleFonts.urbanist(
//               textStyle: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 height: 1.25,
//                 color: AppColors.lightBlueColor,
//               ),
//             ),
//           ),
//           backgroundColor: const Color(0xFFE1F9F2),
//           actions: [
//             IconButton(
//               onPressed: _toggleDrawer,
//               icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Symptoms & Diagnosis',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.blackColor),
//               ),
//               const Divider(
//                 color: AppColors.blackColor,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SxAndDxScreen(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF8F7FC),
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     onChanged: (value) {
//                       // Optional: Add validation or other handling here
//                     },
//                     onSubmitted: (value) {
//                       _onSubmit();
//                     },
//                     decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: Color(0xffF8F7FC),
//                       border: InputBorder.none,
//                       hintText: 'Search by symptoms or diagnosis',
//                       hintStyle: TextStyle(
//                         fontFamily: 'Roboto',
//                         color: Colors.black87,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       icon: Icon(Icons.search, color: Colors.black87),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               const InkWell(
//                 child: Text(
//                   "Frequently searched Symptoms",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff767676),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () => _updateSearchField("Shallow breathing"),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: const Color(0xffF8F8F8),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Text(
//                             "Shallow breathing",
//                             style: GoogleFonts.roboto(
//                               textStyle: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xff0C091F)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (BuildContext context) {
//                           return const FeverAffirmationsSheet(symptomName: "Fever");
//                         },
//                       );
//                     },
//                     child: InkWell(
//                       onTap: () => _updateSearchField("Fever"),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: AppColors.white1Color,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8),
//                             child: Text(
//                               "Fever",
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Roboto'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () => _updateSearchField("Sweating & chills"),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.white1Color,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Sweating & chills",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Roboto'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   InkWell(
//                     onTap: () => _updateSearchField("Headache"),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.white1Color,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Headache",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Roboto'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 6,
//               ),
//               InkWell(
//                 onTap: () => _updateSearchField("Muscle pain"),
//                 child: Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                       color: AppColors.white1Color,
//                       borderRadius: BorderRadius.circular(8)),
//                   child: const Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Text(
//                         "Muscle pain",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Roboto'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
