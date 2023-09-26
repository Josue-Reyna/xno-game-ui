import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/views/scoreboard.dart';
import 'package:xno_game_ui/views/tictactoe_board.dart';
import 'package:xno_game_ui/views/tictactoe_board_same.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});
  static String route = '/game-board';
  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Scoreboard(),
                roomDataProvider.player1.roomID == ''
                    ? const TicTactoeBoardSame()
                    : const TicTactoeBoard(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomText(
                    text:
                        '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                    textAlign: TextAlign.center,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: playerColor[roomDataProvider.roomData['turn']
                            ['color']],
                      ),
                    ],
                    color:
                        playerColor[roomDataProvider.roomData['turn']['color']],
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
      ),
    );
  }
}
