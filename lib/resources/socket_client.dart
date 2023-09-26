import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:xno_game_ui/utils/constants.dart';

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get intance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
