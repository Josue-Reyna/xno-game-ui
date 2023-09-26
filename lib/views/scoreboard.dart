import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  Widget score(String nickname, String points, int color) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: nickname,
            textAlign: TextAlign.center,
            fontSize: 30,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: playerColor.elementAt(color),
              ),
            ],
            color: playerColor.elementAt(color),
          ),
          CustomText(
            text: points,
            textAlign: TextAlign.center,
            fontSize: 30,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: playerColor.elementAt(color),
              ),
            ],
            color: white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        score(
          roomDataProvider.player1.nickname,
          roomDataProvider.player1.points.toInt().toString(),
          roomDataProvider.player1.color.toInt(),
        ),
        score(
          roomDataProvider.player2.nickname,
          roomDataProvider.player2.points.toInt().toString(),
          roomDataProvider.player2.color.toInt(),
        ),
      ],
    );
  }
}
