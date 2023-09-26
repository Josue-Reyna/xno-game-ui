import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/socket_methods.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/utils/utils.dart';
import 'package:xno_game_ui/widgets/custom_button.dart';
import 'package:xno_game_ui/widgets/custom_text_field.dart';
import 'package:xno_game_ui/widgets/screen_view.dart';
import 'package:xno_game_ui/widgets/screen_section.dart';

class JoinRoomScreen extends StatefulWidget {
  static String route = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  final _formKey = GlobalKey<FormState>();

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
  bool join = true;

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.joinAuthSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    Size size = MediaQuery.of(context).size;
    return ScreenView(
      height: join ? size.height * 0.45 : 50,
      child: join
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    controller: _gameIdController,
                    hintText: size.width < 600 ? 'Game ID' : 'Enter Game ID',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter a game ID';
                      }
                      final isValid =
                          RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(val);
                      if (!isValid) {
                        return 'Enter a valid ID';
                      }
                      return null;
                    },
                  ),
                ),
                height20,
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _socketMethods.joinAuth(_gameIdController.text);
                      setState(() {
                        join = !join;
                      });
                    }
                  },
                  text: 'Join',
                ),
                height20,
                goBackButton(context),
              ],
            )
          : ScreenSection(
              title: 'Join Room',
              bottons: bottonsPressedFunction(
                false,
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
              rounds: null,
              gameButton: CustomButton(
                onTap: () {
                  if (color != (roomDataProvider.roomData['turn']['color']) &&
                      color != -1) {
                    _socketMethods.joinRoom(
                      _nameController.text,
                      _gameIdController.text,
                      color,
                    );
                  } else if (color == -1) {
                    showSnackBar(
                      context,
                      chooseColorMessage,
                      blue,
                    );
                  } else {
                    showSnackBar(
                      context,
                      'Sorry 😬, ${roomDataProvider.roomData['turn']['nickname']} chose that color 🤪',
                      red,
                    );
                  }
                },
                text: gameOnMessage,
              ),
              sameDevice: false,
              join: true,
            ),
    );
  }
}
