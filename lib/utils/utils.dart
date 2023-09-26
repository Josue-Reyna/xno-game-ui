import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/game_methods.dart';
import 'package:xno_game_ui/resources/socket_methods.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/widgets/custom_button.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';

final SocketMethods _socketMethods = SocketMethods();

Widget bottonsPressedFunction(
  bool player,
  List<bool> isColorPressed,
  Function function,
) {
  List<Widget> colores = [];
  for (var i = 0; i < playerColor.length; i++) {
    colores.add(
      CustomButton(
        onTap: () => function(i),
        backColor: isColorPressed[i] ? playerColor[i] : backgroundColor,
        text: player ? 'X' : 'O',
        color: isColorPressed[i] ? backgroundColor : playerColor[i],
      )
          .animate(
            onPlay: (controller) =>
                isColorPressed[i] == true ? controller.loop() : null,
          )
          .shake(duration: 700.ms)
          .shimmer(duration: 1000.ms)
          .then(delay: 500.ms),
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 48.0,
    ),
    child: Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: colores,
    ),
  );
}

CustomButton goBackButton(BuildContext context) => CustomButton(
      onTap: () => Navigator.of(context).pop(),
      text: goBackMessage,
    );

Widget selectRounds(
  Function buttonFunction1,
  Function buttonFunction2,
  int maxRounds,
  double size,
) {
  return Column(
    children: [
      CustomText(
        color: Colors.white,
        shadows: const [
          Shadow(
            blurRadius: 10,
            color: white,
          ),
        ],
        text: 'Rounds',
        fontSize: size < 600 ? 20 : 40,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => buttonFunction1(maxRounds),
              text: '5',
              backColor: maxRounds == 5 ? blue : backgroundColor,
              color: maxRounds == 5 ? backgroundColor : blue,
            )
                .animate(
                  onPlay: (controller) =>
                      maxRounds == 5 ? controller.loop() : null,
                )
                .shake(duration: 700.ms)
                .shimmer(duration: 1000.ms)
                .then(delay: 500.ms),
            width50,
            CustomButton(
              onTap: () => buttonFunction2(maxRounds),
              text: '10',
              backColor: maxRounds == 10 ? pink : backgroundColor,
              color: maxRounds == 10 ? backgroundColor : pink,
            )
                .animate(
                  onPlay: (controller) =>
                      maxRounds == 10 ? controller.loop() : null,
                )
                .shake(duration: 700.ms)
                .shimmer(duration: 1000.ms)
                .then(delay: 500.ms),
          ],
        ),
      ),
    ],
  );
}

void showSnackBar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const StadiumBorder(),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      elevation: 10,
      dismissDirection: DismissDirection.horizontal,
      content: CustomText(
        text: content,
        color: color,
        fontSize: 25,
        textAlign: TextAlign.center,
        shadows: [
          Shadow(
            blurRadius: 60,
            color: color,
          ),
        ],
      ),
    ),
  );
}

void showGameDialog(
  BuildContext context,
  String text, {
  String roomId = '',
  bool again = false,
}) {
  showDialog(
    context: context,
    builder: (context) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      return AlertDialog(
        elevation: 20,
        actionsPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        title: CustomText(
          text: text,
          fontSize: 15,
          shadows: const [
            Shadow(
              blurRadius: 10,
              color: white,
            ),
          ],
          color: white,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!again)
                    CustomButton(
                      onTap: () {
                        GameMethods().clearBoard(
                          context,
                          again: true,
                        );
                        if (roomId != '') {
                          _socketMethods.again(roomId);
                        } else {
                          roomDataProvider.updatePlayer1(
                            {
                              'nickname': 'X',
                              'socketID': '',
                              'roomID': '',
                              'points': 0,
                              'playerType': 'X',
                              'color': roomDataProvider.player1.color,
                              'uid': '',
                            },
                          );
                          roomDataProvider.updatePlayer2(
                            {
                              'nickname': 'O',
                              'socketID': '',
                              'roomID': '',
                              'points': 0,
                              'playerType': 'O',
                              'color': roomDataProvider.player2.color,
                              'uid': '',
                            },
                          );
                          Navigator.pop(context);
                        }
                      },
                      text: 'Again',
                      color: blue,
                    ),
                  if (again)
                    const CustomText(
                      text: '✌️😢',
                      fontSize: 15,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: white,
                        ),
                      ],
                      color: white,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
