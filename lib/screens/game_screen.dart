import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/socket_methods.dart';
import 'package:xno_game_ui/screens/game_board.dart';
import 'package:xno_game_ui/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  static String route = '/game';
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    _socketMethods.againListener(context);
    _socketMethods.exitListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaintingLobby()
          : /*  ListView(
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Scoreboard(),
                      const TicTactoeBoard(),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: CustomText(
                          text:
                              '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                          textAlign: TextAlign.center,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: playerColor[
                                  roomDataProvider.roomData['turn']['color']],
                            ),
                          ],
                          color: playerColor[roomDataProvider.roomData['turn']
                              ['color']],
                        )
                            .animate(
                              onPlay: (controller) => controller.loop(),
                            )
                            .shimmer(duration: 1000.ms)
                            .then(delay: 2000.ms),
                      ),
                    ],
                  ),
                ),
              ],
            ), */
          const GameBoard(),
    );
  }
}
