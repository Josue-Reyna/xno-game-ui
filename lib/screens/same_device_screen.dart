import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/models/player.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/screens/game_board.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/utils/utils.dart';
import 'package:xno_game_ui/widgets/custom_button.dart';
import 'package:xno_game_ui/widgets/screen_view.dart';
import 'package:xno_game_ui/widgets/screen_section.dart';

class SameDeviceScreen extends StatefulWidget {
  static String route = '/same-device';
  const SameDeviceScreen({super.key});

  @override
  State<SameDeviceScreen> createState() => _SameDeviceScreenState();
}

class _SameDeviceScreenState extends State<SameDeviceScreen> {
  int color1 = -1;
  int color2 = -1;
  List<bool> isColor1Pressed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> isColor2Pressed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int maxRounds = 0;

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    double size = MediaQuery.of(context).size.width;
    return ScreenView(
      child: ScreenSection(
        title: 'Player X',
        bottons: bottonsPressedFunction(
          true,
          isColor1Pressed,
          (int i) => setState(() {
            for (var j = 0; j < playerColor.length; j++) {
              isColor1Pressed[j] = false;
            }
            isColor1Pressed[i] = true;
            color1 = i;
          }),
        ),
        nameController: null,
        rounds: selectRounds(
          (int maxRoundsSelected) => setState(() {
            maxRounds = 5;
          }),
          (int maxRoundsSelected) => setState(() {
            maxRounds = 10;
          }),
          maxRounds,
          size,
        ),
        gameButton: CustomButton(
          onTap: () {
            if (color2 != color1 &&
                color1 != -1 &&
                color2 != -1 &&
                maxRounds != 0) {
              if (maxRounds != 0) {
                Player player1 = Player(
                  nickname: 'X',
                  socketID: '',
                  roomID: '',
                  points: 0,
                  playerType: 'X',
                  color: color1,
                );
                Player player2 = Player(
                  nickname: 'O',
                  socketID: '',
                  roomID: '',
                  points: 0,
                  playerType: 'O',
                  color: color2,
                );
                final Map<String, dynamic> room = {
                  'turn': player1.toMap(),
                  'turnIndex': 0,
                  'maxRounds': maxRounds,
                };
                roomDataProvider.updateRoomData(room);
                roomDataProvider.updatePlayer1(player1.toMap());
                roomDataProvider.updatePlayer2(player2.toMap());
                Navigator.pushNamed(context, GameBoard.route);
              }
            } else if (color1 == color2) {
              if (color1 == -1) {
                showSnackBar(
                  context,
                  'Both of you have to choose a color! 🤪',
                  red,
                );
              } else {
                showSnackBar(
                  context,
                  'Sorry 😬, player\'s colors have to be different 🤪',
                  yellow,
                );
              }
            } else if (color1 == -1) {
              showSnackBar(
                context,
                'Sorry 😬, player ✖️ has to choose a color 🤪',
                blue,
              );
            } else if (color2 == -1) {
              showSnackBar(
                context,
                'Sorry 😬, player ⭕ has to choose a color 🤪',
                blue,
              );
            } else if (maxRounds == 0) {
              showSnackBar(
                context,
                maxRoundsMessage,
                red,
              );
            }
          },
          text: gameOnMessage,
        ),
        sameDevice: true,
        bottonsO: bottonsPressedFunction(
          false,
          isColor2Pressed,
          (int i) => setState(() {
            for (var j = 0; j < playerColor.length; j++) {
              isColor2Pressed[j] = false;
            }
            isColor2Pressed[i] = true;
            color2 = i;
          }),
        ),
        join: false,
      ),
    );
  }
}
