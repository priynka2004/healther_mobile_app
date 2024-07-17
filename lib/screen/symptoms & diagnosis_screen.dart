import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healther_mobile_app/bottom_sheet/fever_affiramtions_sheet.dart';
import 'package:healther_mobile_app/screen/sx&dx_screen.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/widget/diagnosis_container.dart';
import 'package:healther_mobile_app/widget/symptoms_container.dart';

class SymptomsDiagnosisScreen extends StatefulWidget {
  final List<String> selectedSx;
  final List<String> selectedDx;
  final String? symptoms;

  const SymptomsDiagnosisScreen({
    Key? key,
    required this.selectedSx,
    required this.selectedDx, this.symptoms,
  }) : super(key: key);

  @override
  State<SymptomsDiagnosisScreen> createState() =>
      _SymptomsDiagnosisScreenState();
}

class _SymptomsDiagnosisScreenState extends State<SymptomsDiagnosisScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showPneumoniaTextField = false;
  bool _isDrawerOpen = false;
  List<Map<String, String>> symptoms = [
    {"name": "Fever", "duration": "Duration e.g. 1 day"}
  ];

  Set<String> tappedSymptoms = {};

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

  void addSymptom(String name, String duration) {
    setState(() {
      symptoms.add({"name": name, "duration": duration});
    });
  }

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
            'Digital Prescription',
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SYMPTOMS & DIAGNOSIS',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const Divider(
                        color: AppColors.blackColor,
                      ),
                      TextFormField(
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF8F7FC),
                          border: InputBorder.none,
                          label: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SxAndDxScreen(),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.search, color: Colors.black87)),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'Search by symptoms or diagnosis',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Symptoms',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFC9F0E5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:Column(
                                children: symptoms.map((symptom) {
                                  final selected =
                                  tappedSymptoms.contains(symptom["name"]);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (symptom["name"] == "Fever" && !selected) {
                                          // tappedSymptoms.add("Fever");
                                          // setState(() {
                                          //   symptom["duration"] = "5 hrs";
                                          // });
                                          // addSymptom("Seizure", "once a month");
                                          // addSymptom("Chills", "5 hrs");
                                        }
                                        // else if (symptom["name"] == "Seizure" && selected) {
                                        //   removeSymptom("Seizure");
                                        // }
                                      },
                                      child: buildSymptomContainer(
                                          widget.symptoms ?? 'Fever',
                                          symptom["duration"]!,
                                          selected),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 4),
                            ///***********************************************************
                            if (widget.selectedSx != null)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.selectedSx.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC9F0E5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(widget.selectedSx[index],maxLines: 1,),
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
                                          GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  backgroundColor: Colors.transparent,
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return  FeverAffirmationsSheet(symptomName: widget.selectedSx[index],);
                                                  },
                                                );
                                              },
                                              child: buildIcon(Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC))),
                                          const SizedBox(width: 6),
                                          buildIcon(Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Diagnosis',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                      if (widget.selectedDx != null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.selectedDx.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC9F0E5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(widget.selectedDx[index],maxLines: 1 ,),
                                    ),
                                    const Spacer(),
                                   // buildIcon(Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC)),
                                    const SizedBox(width: 6),
                                    buildIcon(Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 16),
                      if (!showPneumoniaTextField) ...[
                        const Text(
                          'Associated Symptoms',
                          style: TextStyle(
                            color: Color(0xFF1B9C85),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Shallow breathing",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Fever",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Sweating & chills",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Headache",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Muscle pain",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          'Differential Diagnosis',
                          style: TextStyle(
                            color: Color(0xFF1B9C85),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPneumoniaTextField = !showPneumoniaTextField;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white1Color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Pneumonia",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Malaria",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Typhoid",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Common Cold",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Influenza",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                      if (showPneumoniaTextField) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Diagnosis",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFC9F0E5),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Pneumonia',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    const SizedBox(width: 6),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///*******************************************************************

                        if (widget.selectedDx != null)
                          SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.selectedDx.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC9F0E5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8,right: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(widget.selectedDx[index]),
                                        ),
                                        buildIcon(Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        const Divider(),
                        const Text(
                          'Differential Diagnosis',
                          style: TextStyle(
                            color: Color(0xFF1B9C85),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Malaria",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Typhoid",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Common Cold",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white1Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Influenza",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),







                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  Text(
                                    'PRIVATE NOTES',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.black, endIndent: 2),
                              Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEDFFFA),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Add your notes here.',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Urbanist',
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Sx & Dx have been saved successfully.'),
                        ),
                      );
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


  Widget buildSymptomContainer(String symptom, String details, bool selected,
      {double width = 200}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFC9F0E5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
              padding: const EdgeInsets.all(6.0),
              child:Column(
                children: [
                  Row(
                    children: [
                      Text(
                        symptom,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '- 2 days',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return FeverAffirmationsSheet(symptomName: '',);
                              },
                            );
                          },
                          child: buildIcon(
                              Icons.edit,
                              const Color(0xff0B0B0B),
                              const Color(0xffF8F7FC))),
                      const SizedBox(width: 8),
                      buildIcon(
                          Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
                    ],
                  ),
                ],
              )
          ),
        ),

      ],
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
}

