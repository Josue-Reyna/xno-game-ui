import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:xno_game_ui/screens/create_room_screen.dart';
import 'package:xno_game_ui/screens/join_room_screen.dart';
import 'package:xno_game_ui/screens/same_device_screen.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/widgets/custom_button.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';
import 'package:xno_game_ui/widgets/screen_view.dart';

class MainMenuScreen extends StatelessWidget {
  static String route = '/main-menu';

  static Route<void> mainMenu() {
    return MaterialPageRoute(
      builder: (context) => const MainMenuScreen(),
    );
  }

  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.route);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.route);
  }

  void sameDevice(BuildContext context) {
    Navigator.pushNamed(context, SameDeviceScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScreenView(
      height: 120,
      width: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          height50,
          CustomText(
            shadows: const [
              Shadow(
                blurRadius: 60,
                color: pink,
              ),
            ],
            text: 'X\'s',
            fontSize: size.width < 400 ? 60 : 80,
            color: pink,
            textAlign: TextAlign.start,
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
          height5,
          CustomText(
            color: yellow,
            shadows: const [
              Shadow(
                blurRadius: 60,
                color: yellow,
              ),
            ],
            text: '&',
            fontSize: size.width < 400 ? 40 : 60,
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
          height5,
          CustomText(
            shadows: const [
              Shadow(
                blurRadius: 60,
                color: blue,
              ),
            ],
            text: 'O\'s',
            fontSize: size.width < 400 ? 60 : 80,
            color: cyan,
            textAlign: TextAlign.end,
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
          height40,
          CustomButton(
            onTap: () => createRoom(context),
            text: 'Create Room',
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
          height30,
          CustomButton(
            onTap: () => joinRoom(context),
            text: 'Join Room',
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
          height30,
          CustomButton(
            onTap: () => sameDevice(context),
            text: 'Same Device',
          )
              .animate(
                onPlay: (controller) => controller.loop(),
              )
              .shimmer(duration: 1000.ms, delay: 2000.ms),
        ],
      ),
    );
  }
}
