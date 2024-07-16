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
