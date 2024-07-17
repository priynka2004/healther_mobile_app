import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/bottom_sheet/fever_affiramtions_sheet.dart';
import 'package:healther_mobile_app/screen/sx&dx_screen.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/utils/shared_pref_service.dart';
import 'package:healther_mobile_app/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDigitalPrescriptionScreen extends StatefulWidget {
  const CreateDigitalPrescriptionScreen({
    Key? key,
    this.selectedSymptoms,
    this.selectedDiagnoses,
    this.symptoms,
    this.timePeriod,
    this.duration,
    this.associatedSymptoms,
    this.differentialDiagnoses
  }) : super(key: key);

  final List<String>? selectedSymptoms;
  final List<String>? selectedDiagnoses;
  final List<String>? associatedSymptoms;
  final List<String>? differentialDiagnoses;
  final String? symptoms;
  final String? timePeriod;
  final String? duration;

  @override
  State<CreateDigitalPrescriptionScreen> createState() =>
      _CreateDigitalPrescriptionScreenState();
}

class _CreateDigitalPrescriptionScreenState
    extends State<CreateDigitalPrescriptionScreen> {
  // List<Map<String, String>> symptoms = [
  //   {"name": "Fever", "duration": "Duration e.g. 1 day"}
  // ];
  List<Map<String, String>> symptoms = [];
  Set<String> tappedSymptoms = {};

  bool showPneumoniaTextField = false;
  String times = '';

   final List<String> associatedSymptoms=[];
   final List<String> differentialDiagnoses=[];

  void addSymptom(String name, String duration) {
    setState(() {
      symptoms.add({"name": name, "duration": duration});
    });
  }

  void _removeSymptom(int index) {
    setState(() {
      widget.selectedSymptoms!.removeAt(index);
    });
  }

  void _removeDiagnoses(int index) {
    setState(() {
      widget.selectedDiagnoses!.removeAt(index);
    });
  }

  void removeSymptom(int index) {
    setState(() {
      symptoms.removeAt(index);
    });
  }

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

  String symptomName = '';

  @override
  void initState() {
    super.initState();
    //_loadSavedValue();
    getSharedPreferenceData();
  }

  void getSharedPreferenceData() async {
    String? time = await SharedPrefService.getTimePeriod();
    String? symptomName = await SharedPrefService.getSymptomName();
    setState(() {
      times = time ?? '';
      symptoms.add({
        'title': symptomName ?? 'Fever',
        'timePeriod': time ?? '',
        'duration': 'years',
      });
    });
  }

  // Future<void> _loadSavedValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedValue = prefs.getString('savedValue');
  //   setState(() {
  //     searchController.text = savedValue ?? '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
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
                fontFamily: 'Urbanist',
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        child: Text(
                          'SYMPTOMS & DIAGNOSIS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F7FC),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SxAndDxScreen(),
                              ),
                            );
                          },
                          child: TextField(
                            controller: searchController,
                            enabled: false,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: "Search by symptoms or diagnosis",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              icon: Icon(Icons.search,
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Symptoms',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: AppColors.black1Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          final symptom = symptoms[index];
                          return Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC9F0E5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    symptom['title'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${symptom['timePeriod']} ${symptom['duration']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff0B0B0B),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return FeverAffirmationsSheet(
                                            symptomName:
                                                symptom['title'] ?? '');
                                      },
                                    );
                                  },
                                  child: buildIcon(
                                      Icons.edit,
                                      const Color(0xff0B0B0B),
                                      const Color(0xffF8F7FC)),
                                ),
                                const SizedBox(width: 6),
                                IconButton(
                                  icon: buildIcon(
                                      Icons.close,
                                      const Color(0xffF8F7FC),
                                      const Color(0xff0B0B0B)),
                                  onPressed: () => removeSymptom(index),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4,),
                      if (widget.selectedSymptoms != null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.selectedSymptoms!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC9F0E5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.selectedSymptoms![index],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 80),
                                      child: Text(
                                        " - 1 days",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Urbanist',
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    buildIcon(
                                        Icons.edit,
                                        const Color(0xff0B0B0B),
                                        const Color(0xffF8F7FC)),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => _removeSymptom(index),
                                      child: buildIcon(
                                          Icons.close,
                                          const Color(0xffF8F7FC),
                                          const Color(0xff0B0B0B)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      const Divider(),
                      const SizedBox(height: 12),
                      Text(
                        'Diagnoses',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: AppColors.black1Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      if (widget.selectedDiagnoses != null)
                        SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.selectedDiagnoses?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0),
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC9F0E5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 8, bottom: 8, right: 6),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.selectedDiagnoses![index],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            _removeDiagnoses(index),
                                        child: buildIcon(
                                            Icons.close,
                                            const Color(0xffF8F7FC),
                                            const Color(0xff0B0B0B)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Associated Symptoms',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                color: Color(0xFF1B9C85),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                // fontFamily: 'Urbanist',
                              ),
                            ),
                          ),
                          if (widget.associatedSymptoms != null)
                            SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.associatedSymptoms?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC9F0E5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 8, bottom: 8, right: 6),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.associatedSymptoms![index],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _removeDiagnoses(index),
                                            child: buildIcon(
                                                Icons.close,
                                                const Color(0xffF8F7FC),
                                                const Color(0xff0B0B0B)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          const Divider(),
                          Text(
                            'Differential Diagnosis',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                color: Color(0xFF1B9C85),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                // fontFamily: 'Urbanist',
                              ),
                            ),
                          ),
                          if (widget.differentialDiagnoses != null)
                            SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.differentialDiagnoses?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC9F0E5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 8, bottom: 8, right: 6),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.differentialDiagnoses![index],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _removeDiagnoses(index),
                                            child: buildIcon(
                                                Icons.close,
                                                const Color(0xffF8F7FC),
                                                const Color(0xff0B0B0B)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          const Divider(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sx & Dx have been saved successfully.'),
                            ),
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return const AppointmentScreen();
                          // }));
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF32856E),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSymptomContainer(String symptom, String duration, bool selected,
      {double width = 200}) {
    List<String> symptomsWithBlackText = [
      "Fever",
      "Seizure",
      "Chills",
      "5 hrs"
    ];
    List<String> symptomsWithBlacksText = ["5 hrs", "once a month", "5 hrs"];

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFC9F0E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Text(
              symptom,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: 'Urbanist',
                color: symptomsWithBlackText.contains(symptom)
                    ? Colors.black
                    : Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "- 2 days",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: 'Urbanist',
                color: symptomsWithBlackText.contains(symptom)
                    ? Colors.black
                    : Colors.black,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FeverAffirmationsSheet(
                    symptomName: '',
                  );
                }));
              },
              child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const FeverAffirmationsSheet(
                          symptomName: '',
                        );
                      },
                    );
                  },
                  child: buildIcon(Icons.edit, const Color(0xff0B0B0B),
                      const Color(0xffF8F7FC))),
            ),
            const SizedBox(width: 6),
            buildIcon(
                Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }


  Widget _buildSymptomsList(List<String> symptoms) {
    if (symptoms.isEmpty) {
      return const Text('No associated symptoms found.');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: symptoms.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(symptoms[index]),
        );
      },
    );
  }

  Widget _buildDiagnosesList(List<String> diagnoses) {
    if (diagnoses.isEmpty) {
      return const Text('No differential diagnoses found.');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //itemCount: diagnoses.length,
      itemCount:  widget.differentialDiagnoses?.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(diagnoses[index]),
        );
      },
    );
  }


}










