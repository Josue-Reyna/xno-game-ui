import 'package:flutter/material.dart';
import 'package:xno_game_ui/generated/l10n.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/utils/utils.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';
import 'package:xno_game_ui/widgets/custom_text_field.dart';

class ScreenSection extends StatelessWidget {
  const ScreenSection({
    super.key,
    required this.title,
    required this.bottons,
    required this.nameController,
    required this.rounds,
    required this.gameButton,
    required this.sameDevice,
    this.bottonsO,
    required this.join,
  });
  final String title;
  final Widget bottons;
  final TextEditingController? nameController;
  final Widget? rounds;
  final Widget gameButton;
  final bool sameDevice;
  final Widget? bottonsO;
  final bool join;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        height50,
        CustomText(
          color: white,
          shadows: const [
            Shadow(
              blurRadius: 10,
              color: white,
            ),
          ],
          text: title,
          fontSize: size < 600 ? 30 : 50,
        ),
        height20,
        bottons,
        if (sameDevice)
          Column(
            children: [
              height30,
              CustomText(
                shadows: const [
                  Shadow(
                    blurRadius: 20,
                    color: white,
                  ),
                ],
                text: S.current.playerO,
                fontSize: size < 600 ? 30 : 50,
                color: white,
              ),
              height10,
              bottonsO!,
            ],
          ),
        if (!sameDevice)
          Column(
            children: [
              height20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField(
                  controller: nameController!,
                  validator: null,
                  hintText:
                      size < 600 ? S.current.nickname : S.current.enterNickname,
                ),
              ),
            ],
          ),
        height20,
        if (!join) rounds!,
        height20,
        gameButton,
        height20,
        goBackButton(context),
      ],
    );
  }
}
