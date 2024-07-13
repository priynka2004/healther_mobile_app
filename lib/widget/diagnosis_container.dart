import 'package:flutter/material.dart';

class DiagnosisContainer extends StatelessWidget {
  final String diagnosis;
  final bool isSelected;

  const DiagnosisContainer({
    Key? key,
    required this.diagnosis,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.redAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(bottom: 8),
        child: Text(
          diagnosis,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );}
}