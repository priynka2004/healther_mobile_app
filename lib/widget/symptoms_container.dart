import 'package:flutter/material.dart';

class SymptomContainer extends StatelessWidget {
  final String symptom;
  final String duration;
  final bool isSelected;

  const SymptomContainer({
    Key? key,
    required this.symptom,
    required this.duration,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> symptomsWithBlackText = ["Fever", "Seizure", "Chills"];

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFC9F0E5) : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
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
            const SizedBox(width: 10,),
            Text(
              duration,
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
        buildIcon(
            Icons.edit,
            const Color(0xff0B0B0B),
            const Color(0xffF8F7FC)),

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

}
