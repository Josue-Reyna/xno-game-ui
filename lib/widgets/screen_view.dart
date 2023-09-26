import 'package:flutter/material.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height ?? 30,
              horizontal: width ?? 10,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
