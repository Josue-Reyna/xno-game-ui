import 'package:flutter/material.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/game_methods.dart';
import 'package:xno_game_ui/widgets/grid_box.dart';

class TicTactoeBoardSame extends StatefulWidget {
  const TicTactoeBoardSame({super.key});

  @override
  State<TicTactoeBoardSame> createState() => _TicTactoeBoardSameState();
}

class _TicTactoeBoardSameState extends State<TicTactoeBoardSame> {
  void tapped(int index, RoomDataProvider roomDataProvider) {
    if (roomDataProvider.displayElements[index] == '') {
      final choice = roomDataProvider.roomData['turn']['playerType'];

      final roomUpdate = roomDataProvider.roomData;
      if (roomDataProvider.roomData['turnIndex'] == 0) {
        roomUpdate['turn'] = roomDataProvider.player2.toMap();
        roomUpdate['turnIndex'] = 1;
      } else {
        roomUpdate['turn'] = roomDataProvider.player1.toMap();
        roomUpdate['turnIndex'] = 0;
      }
      roomDataProvider.updateRoomData(roomUpdate);
      roomDataProvider.updateDisplayElements(
        index,
        choice,
      );
      GameMethods().checkWinner(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridBox(
      absorbingPoint: false,
      tappedFunction: tapped,
    );
  }
}
