import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';
import 'package:xno_game_ui/widgets/custom_text_field.dart';

class WaintingLobby extends StatefulWidget {
  const WaintingLobby({super.key});

  @override
  State<WaintingLobby> createState() => _WaintingLobbyState();
}

class _WaintingLobbyState extends State<WaintingLobby> {
  late TextEditingController roonIdController;

  @override
  void initState() {
    super.initState();
    roonIdController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roonIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            text: 'Waiting for a player to join 🕓',
            shadows: [
              Shadow(
                blurRadius: 10,
                color: white,
              ),
            ],
            color: white,
            fontSize: 20,
          ),
          height20,
          const CustomText(
            text: 'Game ID',
            shadows: [
              Shadow(
                blurRadius: 10,
                color: white,
              ),
            ],
            color: white,
            fontSize: 15,
          ),
          height20,
          CustomTextField(
            controller: roonIdController,
            hintText: '',
            validator: null,
            isRedyOnly: true,
          ),
        ],
      ),
    );
  }
}
