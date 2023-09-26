import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/resources/game_methods.dart';
import 'package:xno_game_ui/resources/socket_client.dart';
import 'package:xno_game_ui/screens/game_screen.dart';
import 'package:xno_game_ui/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.intance.socket!;

  Socket get socketClient => _socketClient;

  // Emits
  void createRoom(String nickname, int color, int maxRounds) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
        'color': color,
        'maxRounds': maxRounds,
      });
    }
  }

  void joinRoom(String nickname, String roomId, int color) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
        'color': color,
      });
    }
  }

  void joinAuth(String roomId) {
    if (roomId.isNotEmpty) {
      _socketClient.emit('joinAuth', roomId);
    }
  }

  void sameDevice(int color1, int color2, int maxRounds) {
    _socketClient.emit('sameDevice', {
      'color1': color1,
      'color2': color2,
      'maxRounds': maxRounds,
    });
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void again(String roomId) {
    _socketClient.emit('again', roomId);
  }

  // Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.route);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.route);
    });
  }

  void joinAuthSuccessListener(BuildContext context) {
    _socketClient.on('joinAuthSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void sameDeviceSuccessListener(BuildContext context) {
    _socketClient.on('sameDeviceSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.route);
    });
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data, Colors.red);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
      showGameDialog(
        context,
        '${playerData['nickname']} won the game! 😎🥳🎉',
        roomId: playerData['roomID'],
      );
    });
  }

  void exitListener(BuildContext context) {
    _socketClient.on('exitSuccess', (data) {
      Navigator.of(context).popUntil((route) => false);
      showGameDialog(
        context,
        data.toString(),
        again: true,
      );
    });
  }

  void againListener(BuildContext context) {
    _socketClient.on('againSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pop(context);
    });
  }
}
