import 'package:flutter/material.dart';
import 'package:xno_game_ui/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.border,
    this.backColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final bool? border;
  final Color? backColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        shape: border == null ? BoxShape.rectangle : BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: color ?? Colors.white,
              blurRadius: 10,
              spreadRadius: 2,
              blurStyle: BlurStyle.solid),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: border == null
              ? const RoundedRectangleBorder()
              : const CircleBorder(),
          backgroundColor: backColor ?? backgroundColor,
          minimumSize: Size(
            width / 5,
            50,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: color ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
