import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.shadows,
    required this.text,
    required this.fontSize,
    this.color,
    this.textAlign,
  });
  final List<Shadow> shadows;
  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.lightGreenAccent,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        shadows: shadows,
      ),
    );
  }
}
