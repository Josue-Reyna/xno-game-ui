// Player model

class Player {
  final String nickname;
  final String socketID;
  final String roomID;
  final double points;
  final String playerType;
  final int color;

  Player({
    required this.nickname,
    required this.socketID,
    required this.roomID,
    required this.points,
    required this.playerType,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'roomID': roomID,
      'points': points,
      'playerType': playerType,
      'color': color,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      roomID: map['roomID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
      color: map['color']?.toInt() ?? 0,
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    String? roomID,
    double? points,
    String? playerType,
    int? color,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      roomID: roomID ?? this.roomID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
      color: color ?? this.color,
    );
  }
}
