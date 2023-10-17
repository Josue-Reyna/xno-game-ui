import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:xno_game_ui/generated/l10n.dart';
import 'package:xno_game_ui/models/player.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket? socketClient) async {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    );
    String winner = '';

    final List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var i = 0; i < lines.length; i++) {
      List<int> line = lines[i];
      if (roomDataProvider.displayElements[line[0]] ==
              roomDataProvider.displayElements[line[1]] &&
          roomDataProvider.displayElements[line[0]] ==
              roomDataProvider.displayElements[line[2]] &&
          roomDataProvider.displayElements[line[0]] != '') {
        winner = roomDataProvider.displayElements[line[0]];
        break;
      } else if (roomDataProvider.filledBoxes == 10 && winner == '') {
        showSnackBar(
          context,
          S.current.draw,
          white,
        );
        await Future.delayed(
          const Duration(milliseconds: 500),
        );
        // ignore: use_build_context_synchronously
        GameMethods().clearBoard(context);
      }
    }

    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner &&
          (roomDataProvider.player1.points) !=
              roomDataProvider.roomData['maxRounds'].toInt()) {
        // ignore: use_build_context_synchronously
        showSnackBar(
          context,
          S.current.wonSms(
            roomDataProvider.player1.nickname,
          ),
          white,
        );
        await Future.delayed(
          const Duration(milliseconds: 500),
        );
        // ignore: use_build_context_synchronously
        GameMethods().clearBoard(context);
        if (socketClient != null) {
          socketClient.emit('winner', {
            'winnerId': roomDataProvider.player1.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        } else {
          final newPoints = roomDataProvider.player1.points + 1;
          Player playerUpdate = Player(
            nickname: 'X',
            socketID: '',
            roomID: '',
            points: newPoints,
            playerType: 'X',
            color: roomDataProvider.player1.color,
          );
          roomDataProvider.updatePlayer1(playerUpdate.toMap());
          if (playerUpdate.points == roomDataProvider.roomData['maxRounds']) {
            // ignore: use_build_context_synchronously
            showGameDialog(
              context,
              S.current.winnerMessage(
                roomDataProvider.player1.nickname,
              ),
            );
          }
        }
      } else if (roomDataProvider.player2.playerType == winner &&
          (roomDataProvider.player2.points) !=
              roomDataProvider.roomData['maxRounds'].toInt()) {
        // ignore: use_build_context_synchronously
        showSnackBar(
          context,
          S.current.wonSms(
            roomDataProvider.player2.nickname,
          ),
          white,
        );

        await Future.delayed(
          const Duration(milliseconds: 500),
        );
        // ignore: use_build_context_synchronously
        GameMethods().clearBoard(context);
        if (socketClient != null) {
          socketClient.emit('winner', {
            'winnerId': roomDataProvider.player2.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        } else {
          final newPoints = roomDataProvider.player2.points + 1;
          Player playerUpdate = Player(
            nickname: 'O',
            socketID: '',
            roomID: '',
            points: newPoints,
            playerType: 'O',
            color: roomDataProvider.player2.color,
          );
          roomDataProvider.updatePlayer2(playerUpdate.toMap());
          if (playerUpdate.points == roomDataProvider.roomData['maxRounds']) {
            // ignore: use_build_context_synchronously
            showGameDialog(
              context,
              S.current.winnerMessage(
                roomDataProvider.player2.nickname,
              ),
            );
          }
        }
      }
    }
  }

  void clearBoard(BuildContext context, {bool again = false}) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    );
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFilledBoxesToZero();
    /* if (again) {
      Navigator.pop(context);
    } */
  }
}
