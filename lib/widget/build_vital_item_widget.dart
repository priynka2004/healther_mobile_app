import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomVitalTextField extends StatelessWidget {
  final String title;
  final String unit;
  final TextEditingController controller;
  final String hintText;

  const CustomVitalTextField({
    Key? key,
    required this.title,
    required this.unit,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Color(0xFF0C091F),
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F7FC),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black, // Text color when input is given
                ),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey, // Hint text color
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 1,
          child: Text(
            unit,
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0C091F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
