import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/bottom_sheet/seizure_sheet.dart';
import 'package:healther_mobile_app/screen/create_digital_presscription_screen.dart';
import 'package:healther_mobile_app/service/symptoms_service.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SxAndDxScreen extends StatefulWidget {
  const SxAndDxScreen({super.key});

  @override
  State<SxAndDxScreen> createState() => _SxAndDxScreenState();
}

class _SxAndDxScreenState extends State<SxAndDxScreen> {
  final List<String> _selectedSx = [];
  final List<String> _selectedDx = [];
  bool isSelected = false;
  TextEditingController searchController = TextEditingController();
  List<String> _symptomsList = [];
  List<String> _diagnosesList = [];
  bool isSearching = false;
  Map<String, dynamic> apiResponse = {};

  CreateSymptomsService createSymptomsService = CreateSymptomsService();

  void _toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    isSelected = !isSelected;
    _loadSavedValue();
  }

  void _showSeizuresRequiredMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select "Seizures" to proceed.'),
      ),
    );
  }

  void _showMinimumSymptomsMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select at least 3 symptoms to proceed.'),
      ),
    );
  }

  Future<void> _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString('savedValue');
    setState(() {
      searchController.text = savedValue ?? '';
    });
  }

  Widget _buildResults() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: _symptomsList
                .map((symptom) => ListTile(
              title: Row(
                children: [
                  Transform.scale(
                    scale: 0.9,
                    child: Checkbox(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      value: _selectedSx.contains(symptom),
                      activeColor: const Color(0xFFA1A1A1),
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                          width: 2.0,
                          color: Color(0xFFA1A1A1),
                        ),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedSx.add(symptom);
                          } else {
                            _selectedSx.remove(symptom);
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 4, top: 8, bottom: 8),
                      height: 40,
                      color: const Color(0xffF7F7F7),
                      child: Text(
                        symptom,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  if (_selectedSx.contains(symptom)) {
                    _selectedSx.remove(symptom);
                  } else {
                    _selectedSx.add(symptom);
                  }
                });
              },
              selected: _selectedSx.contains(symptom),
            ))
                .toList(),
          ),
        ),
        Expanded(
          child: Column(
            children: _diagnosesList
                .map((diagnosis) => ListTile(
              title: Row(
                children: [
                  Transform.scale(
                    scale: 0.9,
                    child: Checkbox(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      value: _selectedDx.contains(diagnosis),
                      activeColor: const Color(0xFFA1A1A1),
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                          width: 2.0,
                          color: Color(0xFFA1A1A1),
                        ),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedDx.add(diagnosis);
                          } else {
                            _selectedDx.remove(diagnosis);
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 4, top: 8, bottom: 8),
                      height: 40,
                      color: const Color(0xffF7F7F7),
                      child: Text(
                        diagnosis,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  if (_selectedDx.contains(diagnosis)) {
                    _selectedDx.remove(diagnosis);
                  } else {
                    _selectedDx.add(diagnosis);
                  }
                });
              },
              selected: _selectedDx.contains(diagnosis),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }



  void _searchSymptoms() {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      createSymptomsService
          .createSymptoms(searchController.text, _selectedSx, _selectedDx)
          .timeout(const Duration(seconds: 10))
          .then((result) {
        setState(() {
          _symptomsList = result['symptoms']!;
          _diagnosesList = result['diagnoses']!;
          apiResponse = result;
         // isSearching = false;
        });
      }).catchError((error) {
        // setState(() {
        //   isSearching = false;
        // });
        String errorMessage = 'Error: $error';
        if (error is TimeoutException) {
          errorMessage = 'Network is slow. Please try again later.';
        } else if (error is SocketException || error is http.ClientException) {
          errorMessage = 'Network is unreachable. Please check your connection.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          AppText.sx,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 60,
              decoration: const BoxDecoration(
                  color: AppColors.greenColor, shape: BoxShape.circle),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.greenColor,
                  minimumSize: const Size(140, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // onPressed: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                //     return const CreateDigitalPrescriptionSymptomsScreen();
                //   }));
                // },
                onPressed: _selectedSx.length >= 3 ? () {
                  //if (_selectedSx.length < 3) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Please select at least 3 symptoms.'),
                  //     ),
                  //   );
                  // } else if (_selectedDx.length < 1) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Please select at least 1 diagnosis.'),
                  //     ),
                  //   );
                  // } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return CreateDigitalPrescriptionScreen(
                            selectedDiagnoses: _selectedDx,
                            selectedSymptoms: _selectedSx,
                            symptoms: searchController.text,
                          );
                        }));
                  } : _showMinimumSymptomsMessage,
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return CreateDigitalPrescriptionScreen(
                  //     selectedDiagnoses: _selectedDx,
                  //     selectedSymptoms: _selectedSx,
                  //   );
                  // }));
 // },

                child: const Text(
                  AppText.save,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F7FC),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child:
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search & select',
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    icon: GestureDetector(
                      child:
                      const Icon(Icons.search, color: AppColors.blackColor),
                    ),
                  ),
                  onChanged: (value) {
                    _searchSymptoms();
                  },
                  onSubmitted: (text) {
                    _searchSymptoms();
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  Text(
                    "${_selectedSx.length + _selectedDx.length} selected",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.2,
                      color: Color(0xFFA5A5A5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 8),
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    color: const Color(0xff52CFAC),
                    child: const Center(
                        child:
                        Text("Sx", style: TextStyle(color: Colors.white))),
                  ),
                  const SizedBox(width: 170),
                  Container(
                    height: 24,
                    width: 24,
                    color: AppColors.darkRedColor,
                    child: const Center(
                        child:
                        Text("Dx", style: TextStyle(color: Colors.white))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //isSearching ?
            _buildResults()
            //     : Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Column(
            //         children: buildOptionsList("Sx"),
            //       ),
            //     ),
            //     const SizedBox(width: 20),
            //     Expanded(
            //       child: Column(
            //         children: buildOptionsList("Dx"),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildOptionsList(String type) {
    List<Widget> options = [];
    List<String> sxTitles = [
      "Opt 1",
      "Seizures",
      "Opt 3",
      "Opt 4",
      "Chills",
      "Opt 6",
      "Opt 7",
      "Opt 8",
      "Opt 9",
      "Opt 10",
      "Opt 11",
      "Opt 12",
      "Opt 13"
    ];

    List<String> dxTitles = [
      "Opt 1",
      "Opt 2",
      "Opt 3",
      "Opt 4",
      "Opt 5",
      "Opt 6",
      "Opt 7",
      "Opt 8",
      "Opt 9",
      "Opt 10",
      "Opt 11",
      "Opt 12",
      "Opt 13"
    ];

    bool isSeizuresSelected = _selectedSx.contains("Seizures");
    if (isSeizuresSelected) {
      dxTitles.removeWhere((title) =>
      title == "Opt 7" ||
          title == "Opt 8" ||
          title == "Opt 9" ||
          title == "Opt 10" ||
          title == "Opt 11" ||
          title == "Opt 12" ||
          title == "Opt 14");
    }

    List<String> titles = type == "Sx" ? sxTitles : dxTitles;

    for (String title in titles) {
      options.add(buildOption(title, type));
    }
    return options;
  }

  Widget buildOption(String title, String type) {
    bool isSelectedSx = _selectedSx.contains(title);
    bool isSelectedDx = _selectedDx.contains(title);

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: const BoxDecoration(
            color: Color(0xFFF7F7F7)
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (title == "Seizures") {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const AffirmationsSheet();
                    },
                  );
                } else {
                  setState(() {
                    if (type == "Sx") {
                      if (isSelectedSx) {
                        _selectedSx.remove(title);
                      } else {
                        _selectedSx.add(title);
                      }
                    } else {
                      if (isSelectedDx) {
                        _selectedDx.remove(title);
                      } else {
                        _selectedDx.add(title);
                      }
                    }
                  });
                }
              },
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (type == "Sx") {
                          if (isSelectedSx) {
                            _selectedSx.remove(title);
                          } else {
                            _selectedSx.add(title);
                          }
                        } else {
                          if (isSelectedDx) {
                            _selectedDx.remove(title);
                          } else {
                            _selectedDx.add(title);
                          }
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFFA1A1A1),
                        ),
                        color: (type == "Sx" && isSelectedSx) ||
                            (type == "Dx" && isSelectedDx)
                            ? const Color(0xFFFEFEFE)
                            : Colors.transparent,
                      ),
                      child: (type == "Sx" && isSelectedSx) ||
                          (type == "Dx" && isSelectedDx)
                          ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.black,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Center(
                    child: Text(
                      title,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.2,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}


