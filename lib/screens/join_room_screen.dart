import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/generated/l10n.dart';
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
                    hintText: size.width < 600
                        ? S.current.gameId
                        : S.current.gameIdEx,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.current.gameIdEmpty;
                      }
                      final isValid =
                          RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(val);
                      if (!isValid) {
                        return S.current.gameIdValidate;
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
                  text: S.current.joinButton,
                ),
                height20,
                goBackButton(context),
              ],
            )
          : ScreenSection(
              title: S.current.joinRoom,
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
                      S.current.chooseColorMessage,
                      blue,
                    );
                  } else {
                    showSnackBar(
                      context,
                      S.current.sorrySms(
                        roomDataProvider.roomData['turn']['nickname'],
                      ),
                      red,
                    );
                  }
                },
                text: S.current.gameOnMessage,
              ),
              sameDevice: false,
              join: true,
            ),
    );
  }
}
