import 'package:flutter/material.dart';
import 'package:healther_mobile_app/utils/shared_pref_service.dart';
import 'package:healther_mobile_app/screen/create_digital_presscription_screen.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/utils/string_const.dart';

class FeverAffirmationsSheet extends StatefulWidget {
  const FeverAffirmationsSheet({required this.symptomName, Key? key}) : super(key: key);
  final String symptomName;

  @override
  State<FeverAffirmationsSheet> createState() => _FeverAffirmationsSheetState();
}

class _FeverAffirmationsSheetState extends State<FeverAffirmationsSheet> {
  String? selectedValue;
  final List<String> options = ['hrs', 'days', 'weeks', 'months', 'years'];
  final FocusNode timePeriodFocusNode = FocusNode();
  bool isFocused = false;
  final TextEditingController timePeriodController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    timePeriodFocusNode.addListener(() {
      setState(() {
        isFocused = timePeriodFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    timePeriodFocusNode.dispose();
    timePeriodController.dispose();
    super.dispose();
  }

  Future<void> saveToSharedPreferences() async {
    await SharedPrefService.setSymptomName(widget.symptomName);
    await SharedPrefService.setTimePeriod(timePeriodController.text);
    await SharedPrefService.setDuration(selectedValue ?? 'years');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6 +
            MediaQuery.of(context).viewInsets.bottom,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6 +
                    MediaQuery.of(context).viewInsets.bottom,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 14.10,
                      offset: Offset(3, 3),
                      spreadRadius: 8,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              color: const Color(0xff52CFAC),
                              child: const Center(
                                child: Text(
                                  "Sx",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.symptomName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text(
                              "Time period",
                              style: TextStyle(
                                color: AppColors.black1Color,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: TextFormField(
                                  focusNode: timePeriodFocusNode,
                                  controller: timePeriodController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffFFFFFF),
                                    border: InputBorder.none,
                                    // hintText: '2',
                                    hintStyle: TextStyle(
                                      color: isFocused ? Colors.grey : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Time period is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: selectedValue,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffFFFFFF),
                                    border: InputBorder.none,
                                  ),
                                  items: options.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  },
                                  hint: const Text(
                                    'years',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          AppText.privateNotes,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                        ),
                        const Divider(color: AppColors.blackColor),
                        const SizedBox(height: 4),
                        Container(
                          height: 160,
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
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x0ff5F5F5),
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffF5F5F5),
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(
                                      color: AppColors.black1Color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.greenColor,
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String timePeriod = timePeriodController.text;
                                      String duration = selectedValue ?? 'years';

                                      await saveToSharedPreferences();

                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return CreateDigitalPrescriptionScreen(
                                          symptoms: widget.symptomName,
                                          timePeriod: timePeriod,
                                          duration: duration,
                                        );
                                      }));
                                    }
                                  },
                                  child: const Text(
                                    AppText.save,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
