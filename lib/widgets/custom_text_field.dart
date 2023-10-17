import 'package:flutter/material.dart';
import 'package:xno_game_ui/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isRedyOnly;
  final String hintText;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isRedyOnly = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: white,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 15),
        validator: validator,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            backgroundColor: backgroundColor,
            color: red,
          ),
          fillColor: backgroundColor,
          filled: true,
          hintText: hintText,
        ),
        readOnly: isRedyOnly,
      ),
    );
  }
}
