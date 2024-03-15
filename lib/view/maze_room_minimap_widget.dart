import 'package:flutter/material.dart';
import '/model/game_session.dart';

import '/model/maze_room.dart';

class MazeRoomMinimapWidget extends StatelessWidget {
  final MazeRoom room;
  final GameSession? gameSession;

  const MazeRoomMinimapWidget(
      {super.key, required this.room, this.gameSession});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                _backgroundForRoomType(),
                FittedBox(fit: BoxFit.contain, child: Text('${room.intValue}')),
                FittedBox(fit: BoxFit.contain, child: _iconForRoomType()),
              ],
            )));
  }

  Widget _iconForRoomType() => switch (room) {
        _ when gameSession?.currentLocation == room.location =>
          Icon(Icons.person),
        _ when room.isStartingRoom =>
          Icon(Icons.star, color: Colors.yellow.withOpacity(0.7)),
        _ when room.isEndRoom =>
          Icon(Icons.flag, color: Colors.green.withOpacity(0.7)),
        _ => Container(),
      };

  Widget _backgroundForRoomType() => switch (room) {
        _ when room.isStartingRoom => Container(color: Colors.grey),
        _ when room.isEndRoom => Container(color: Colors.grey),
        _ => Container(),
      };
}
