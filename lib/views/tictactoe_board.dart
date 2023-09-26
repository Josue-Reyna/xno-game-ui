import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/socket_methods.dart';
import 'package:xno_game_ui/widgets/grid_box.dart';

class TicTactoeBoard extends StatefulWidget {
  const TicTactoeBoard({super.key});

  @override
  State<TicTactoeBoard> createState() => _TicTactoeBoardState();
}

class _TicTactoeBoardState extends State<TicTactoeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  void dispose() {
    _socketMethods.socketClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return GridBox(
        absorbingPoint: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethods.socketClient.id,
        tappedFunction: tapped);
  }
}
