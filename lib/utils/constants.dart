import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Colors
const backgroundColor = Color.fromARGB(255, 40, 38, 51);
const white = Colors.white;
const purple = Colors.deepPurpleAccent;
const pink = Colors.pinkAccent;
const red = Colors.redAccent;
const yellow = Colors.yellowAccent;
const orange = Colors.orange;
const green = Colors.greenAccent;
const cyan = Colors.cyanAccent;
const blue = Colors.blueAccent;

const playerColor = [
  purple,
  pink,
  red,
  orange,
  yellow,
  green,
  cyan,
  blue,
];

final uri = dotenv.env['CONNECT']!;

// Spacers
const height5 = SizedBox(height: 5);
const height10 = SizedBox(height: 10);
const height20 = SizedBox(height: 20);
const height30 = SizedBox(height: 30);
const height40 = SizedBox(height: 40);
const height50 = SizedBox(height: 50);
const width50 = SizedBox(width: 50);

// Messages
const maxRoundsMessage = 'Sorry 😬, you have to choose a maximum rounds 🤪';
const chooseColorMessage = 'Sorry 😬, you have to choose a color 🤪';
const gameOnMessage = 'Game On!🕹️';
const goBackMessage = 'Go Back↩️';
