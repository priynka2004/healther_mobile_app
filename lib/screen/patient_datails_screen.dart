// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:healther_mobile_app/screen/create_digital_prescription_screens.dart';
// import 'package:healther_mobile_app/screen/create_digital_presscription_screen.dart';
// import 'package:healther_mobile_app/screen/patient_data_screen.dart';
// import 'package:healther_mobile_app/widget/CustomTextField.dart';
// import 'package:healther_mobile_app/utils/app_colors.dart';
// import 'package:healther_mobile_app/widget/birthdate_container.dart';
// import 'package:healther_mobile_app/widget/build_vital_item_widget.dart';
// import 'package:healther_mobile_app/widget/gender_dropdown.dart';
// import 'package:healther_mobile_app/utils/string_const.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PatientDetailsScreen extends StatefulWidget {
//   const PatientDetailsScreen({super.key});
//
//   @override
//   State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
// }
//
// class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
//   TextEditingController spo2Controller = TextEditingController();
//   TextEditingController pulseRateController = TextEditingController();
//   TextEditingController rbsController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController reasonController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController appointmentBriefController = TextEditingController();
//   DateTime? _dob;
//   String? genderText;
//   File? _image;
//   bool showDuplicateNumberMessage = false;
//   bool showInvalidNumberMessage = false;
//
//   List<String> existingNumbers = [];
//   List<String> _timeSlots = [];
//   String? _selectedTimeSlot;
//
//   @override
//   void initState() {
//     super.initState();
//     _timeSlots = generateTimeSlots();
//     firstNameController.addListener(_updateButtonColors);
//     mobileNumberController.addListener(_updateButtonColors);
//     ageController.addListener(_updateButtonColors);
//     reasonController.addListener(_updateButtonColors);
//   }
//
//   @override
//   void dispose() {
//     mobileNumberController.removeListener(_updateButtonColors);
//     firstNameController.removeListener(_updateButtonColors);
//     ageController.removeListener(_updateButtonColors);
//     reasonController.removeListener(_updateButtonColors);
//     mobileNumberController.dispose();
//     firstNameController.dispose();
//     ageController.dispose();
//     reasonController.dispose();
//     lastNameController.dispose();
//     super.dispose();
//   }
//
//   List<String> generateTimeSlots() {
//     List<String> timeSlots = ['Select Time Slot'];
//     DateTime startTime = DateTime(2021, 1, 1, 9, 0);
//     DateTime endTime = DateTime(2021, 1, 1, 18, 0);
//
//     while (startTime.isBefore(endTime)) {
//       DateTime nextTime = startTime.add(const Duration(minutes: 15));
//       timeSlots.add(
//           "${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
//       startTime = nextTime;
//     }
//     return timeSlots;
//   }
//
//   int calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     if (currentDate.month < birthDate.month ||
//         (currentDate.month == birthDate.month &&
//             currentDate.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
//
//   void _pickDOB() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//
//     if (pickedDate != null && pickedDate != _dob) {
//       setState(() {
//         _dob = pickedDate;
//         int age = calculateAge(pickedDate);
//         ageController.text = age.toString();
//       });
//     }
//   }
//
//   bool _isDuplicateNumber(String number) {
//     return existingNumbers.contains(number);
//   }
//
//   void _checkDuplicateNumber() {
//     String number = mobileNumberController.text;
//     if (number.length != 10) {
//       setState(() {
//         showInvalidNumberMessage = true;
//         showDuplicateNumberMessage = false;
//       });
//     } else if (_isDuplicateNumber(number)) {
//       setState(() {
//         showDuplicateNumberMessage = true;
//         showInvalidNumberMessage = false;
//       });
//     } else {
//       setState(() {
//         showDuplicateNumberMessage = false;
//         showInvalidNumberMessage = false;
//       });
//     }
//   }
//
//   bool _isFormComplete() {
//     return mobileNumberController.text.isNotEmpty &&
//         firstNameController.text.isNotEmpty &&
//         ageController.text.isNotEmpty &&
//         genderText != null &&
//         _dob != null &&
//         mobileNumberController.text.length == 10;
//   }
//
//   void _updateButtonColors() {
//     setState(() {});
//   }
//
//   String formatDate(DateTime? date) {
//     if (date == null) return 'Birthdate';
//     return DateFormat('yyyy-MM-dd').format(date);
//   }
//
//   void _saveData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('mobileNumber', mobileNumberController.text);
//     prefs.setString('firstName', firstNameController.text);
//     prefs.setString('age', ageController.text);
//     prefs.setString('gender', genderText!);
//     if (_dob != null) {
//       prefs.setString('dob', _dob!.toIso8601String());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isFormComplete = _isFormComplete();
//
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 30,
//         title: const Text(
//           AppText.patientDetails,
//           style: TextStyle(fontSize: 20),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.blackColor),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: InkWell(
//                 onTap: () {
//                   _saveData();
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const PatientDetailsScreen();
//                   }));
//                 },
//                 child: const Icon(
//                   Icons.close_rounded,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         AppText.personalDetails,
//                         style: GoogleFonts.urbanist(
//                           textStyle: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                               color: Color(0xff605C72)),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       CustomTextField(
//                         controller: mobileNumberController,
//                         hintText: AppText.mobileNo,
//                         keyBoardType: TextInputType.phone,
//                         height: 52,
//                         onChanged: (value) {
//                           _checkDuplicateNumber();
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       CustomTextField(
//                         controller: firstNameController,
//                         hintText: AppText.name,
//                         height: 52,
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: BirthDate(
//                               selectedDate: _dob,
//                               onTap: _pickDOB,
//                               width: 0.45,
//                               text: AppText.birthDate,
//                               showIcon: true,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           CustomTextField(
//                             controller: ageController,
//                             hintText: AppText.age,
//                             height: 52,
//                             width: MediaQuery.of(context).size.width * 0.45,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: GenderContainer(
//                               value: genderText,
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   genderText = newValue;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             AppText.vitals,
//                             style: TextStyle(
//                               color: AppColors.bluColor,
//                               fontFamily: 'Urbanist',
//                               fontWeight: FontWeight.w600,
//                               fontSize: 17,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           CustomVitalTextField(
//                             title: 'SpO2 levels',
//                             unit: '%',
//                             controller: spo2Controller,
//                             hintText: '90',
//                           ),
//                           const SizedBox(height: 16),
//                           CustomVitalTextField(
//                             title: 'Pulse Rate',
//                             unit: 'beats/min',
//                             controller: pulseRateController,
//                             hintText: '60',
//                           ),
//                           const SizedBox(height: 16),
//                           CustomVitalTextField(
//                             title: 'RBS',
//                             unit: 'mg/dL',
//                             controller: rbsController,
//                             hintText: '60',
//                           ),
//                         ],
//                       ),
//                     ]),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 _saveData();
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return const CreateDigitalPrescriptionScreens();
//                 }));
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.resolveWith<Color>((states) {
//                   if (states.contains(MaterialState.disabled)) {
//                     return const Color(0xFF32856E);
//                   }
//                   return const Color(0xFF32856E);
//                 }),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(7.0),
//                   ),
//                 ),
//               ),
//               child: Container(
//                 height: 60,
//                 child: const Center(
//                   child: Text(
//                     "Proceed to Symptoms & \nDiagnosis",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/screen/create_digital_prescription_screens.dart';
import 'package:healther_mobile_app/screen/patient_data_screen.dart';
import 'package:healther_mobile_app/utils/save_token.dart';
import 'package:healther_mobile_app/widget/CustomTextField.dart';
import 'package:healther_mobile_app/widget/birthdate_container.dart';
import 'package:healther_mobile_app/widget/build_vital_item_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final SharedPrefService _prefsService = SharedPrefService();
  TextEditingController spo2Controller = TextEditingController();
  TextEditingController pulseRateController = TextEditingController();
  TextEditingController rbsController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController appointmentBriefController = TextEditingController();
  DateTime? _dob;
  String? genderText;
  File? _image;
  bool showDuplicateNumberMessage = false;
  bool showInvalidNumberMessage = false;

  List<String> existingNumbers = [];
  List<String> _timeSlots = [];
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _timeSlots = generateTimeSlots();
    firstNameController.addListener(_updateButtonColors);
    mobileNumberController.addListener(_updateButtonColors);
    ageController.addListener(_updateButtonColors);
    reasonController.addListener(_updateButtonColors);
    _loadData();
  }

  @override
  void dispose() {
    mobileNumberController.removeListener(_updateButtonColors);
    firstNameController.removeListener(_updateButtonColors);
    ageController.removeListener(_updateButtonColors);
    reasonController.removeListener(_updateButtonColors);
    mobileNumberController.dispose();
    firstNameController.dispose();
    ageController.dispose();
    reasonController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  List<String> generateTimeSlots() {
    List<String> timeSlots = ['Select Time Slot'];
    DateTime startTime = DateTime(2021, 1, 1, 9, 0);
    DateTime endTime = DateTime(2021, 1, 1, 18, 0);

    while (startTime.isBefore(endTime)) {
      DateTime nextTime = startTime.add(const Duration(minutes: 15));
      timeSlots.add(
          "${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
      startTime = nextTime;
    }
    return timeSlots;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _pickDOB() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
        int age = calculateAge(pickedDate);
        ageController.text = age.toString();
      });
    }
  }

  bool _isDuplicateNumber(String number) {
    return existingNumbers.contains(number);
  }

  void _checkDuplicateNumber() {
    String number = mobileNumberController.text;
    if (number.length != 10) {
      setState(() {
        showInvalidNumberMessage = true;
        showDuplicateNumberMessage = false;
      });
    } else if (_isDuplicateNumber(number)) {
      setState(() {
        showDuplicateNumberMessage = true;
        showInvalidNumberMessage = false;
      });
    } else {
      setState(() {
        showDuplicateNumberMessage = false;
        showInvalidNumberMessage = false;
      });
    }
  }

  bool _isFormComplete() {
    return mobileNumberController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        genderText != null &&
        _dob != null &&
        mobileNumberController.text.length == 10;
  }

  void _updateButtonColors() {
    setState(() {});
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Birthdate';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobileNumber', mobileNumberController.text);
    prefs.setString('firstName', firstNameController.text);
    prefs.setString('age', ageController.text);
    prefs.setString('gender', genderText!);
    if (_dob != null) {
      prefs.setString('dob', _dob!.toIso8601String());
    }
    prefs.setString('spo2', spo2Controller.text);
    prefs.setString('pulseRate', pulseRateController.text);
    prefs.setString('rbs', rbsController.text);
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumberController.text = prefs.getString('mobileNumber') ?? '';
      firstNameController.text = prefs.getString('firstName') ?? '';
      ageController.text = prefs.getString('age') ?? '';
      genderText = prefs.getString('gender');
      if (prefs.getString('dob') != null) {
        try {
          _dob = DateTime.parse(prefs.getString('dob')!);
        } catch (e) {
          _dob = null;
        }
      }
      spo2Controller.text = prefs.getString('spo2') ?? '';
      pulseRateController.text = prefs.getString('pulseRate') ?? '';
      rbsController.text = prefs.getString('rbs') ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isFormComplete = _isFormComplete();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(
          'Patient Details',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              child: InkWell(
                onTap: () {
                  _saveData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SavedDataScreen();
                  }));
                },
                child: const Icon(
                  Icons.close_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Personal Details',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xff605C72)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: mobileNumberController,
                        hintText: 'Mobile No',
                        keyBoardType: TextInputType.phone,
                        height: 52,
                        onChanged: (value) {
                          _checkDuplicateNumber();
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: firstNameController,
                        hintText: 'Name',
                        height: 52,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: BirthDate(
                              selectedDate: _dob,
                              onTap: _pickDOB,
                              width: 0.45,
                              text: 'Birthdate',
                              showIcon: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomTextField(
                            controller: ageController,
                            hintText: 'Age',
                            height: 52,
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: genderText != null && genderText!.isNotEmpty
                            ? genderText
                            : null,
                        items: <String>['Male', 'Female', 'Other']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            genderText = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Select Gender",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vitals',
                            style: TextStyle(
                              color: Color(0xff605C72),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomVitalTextField(
                            title: 'SpO2 levels',
                            unit: '%',
                            controller: spo2Controller,
                            hintText: '90',
                          ),
                          const SizedBox(height: 16),
                          CustomVitalTextField(
                            title: 'Pulse Rate',
                            unit: 'beats/min',
                            controller: pulseRateController,
                            hintText: '60',
                          ),
                          const SizedBox(height: 16),
                          CustomVitalTextField(
                            title: 'RBS',
                            unit: 'mg/dL',
                            controller: rbsController,
                            hintText: '60',
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CreateDigitalPrescriptionScreens();
                }));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const Color(0xFF32856E);
                  }
                  return const Color(0xFF32856E);
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
              child: Container(
                height: 60,
                child: const Center(
                  child: Text(
                    "Proceed to Symptoms & \nDiagnosis",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
