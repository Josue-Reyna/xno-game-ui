import 'package:flutter/material.dart';
import 'package:xno_game_ui/generated/l10n.dart';
import 'package:xno_game_ui/resources/socket_methods.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/utils/utils.dart';
import 'package:xno_game_ui/widgets/custom_button.dart';
import 'package:xno_game_ui/widgets/screen_view.dart';
import 'package:xno_game_ui/widgets/screen_section.dart';

class CreateRoomScreen extends StatefulWidget {
  static String route = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  int color = -1;
  List<bool> isColorPressed = [
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
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _socketMethods.updateRoomListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ScreenView(
      child: ScreenSection(
        title: S.current.createRoom,
        bottons: bottonsPressedFunction(
          true,
          isColorPressed,
          (int i) => setState(() {
            for (var j = 0; j < playerColor.length; j++) {
              isColorPressed[j] = false;
            }
            isColorPressed[i] = true;
            color = i;
          }),
        ),
        nameController: _nameController,
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
            if (color != -1) {
              if (maxRounds != 0) {
                _socketMethods.createRoom(
                  _nameController.text,
                  color,
                  maxRounds,
                );
              } else {
                showSnackBar(
                  context,
                  S.current.maxRoundsMessage,
                  red,
                );
              }
            } else {
              showSnackBar(
                context,
                S.current.chooseColorMessage,
                red,
              );
            }
          },
          text: S.current.createButton,
        ),
        sameDevice: false,
        join: false,
      ),
    );
  }
}
