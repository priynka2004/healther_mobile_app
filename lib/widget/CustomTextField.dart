import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final double? width;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyBoardType;

  const CustomTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.height,
    this.width,
    this.onChanged,
    this.keyBoardType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width:
      width ?? MediaQuery.of(context).size.width,
      color: const Color(0xffF5F5F5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            keyboardType: keyBoardType,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
