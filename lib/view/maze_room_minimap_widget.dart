import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/maze_room.dart';

class MazeRoomMinimapWidget extends StatelessWidget {
  final MazeRoom room;

  const MazeRoomMinimapWidget({super.key, required this.room});

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
                FittedBox(
                  fit: BoxFit.contain,
                    child: _backgroundForRoomType()
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text('${room.intValue}'),
                ),
              ],
            )));
  }

  Widget _backgroundForRoomType() => switch (room) {
        _ when room.isStartingRoom => _startingRoomBackground(),
        _ when room.isEndRoom => _endRoomBackground(),
        _ => _ordinaryRoomBackground(),
      };

  Widget _startingRoomBackground() {
    return Container(
      color: Colors.grey,
      child: Icon(Icons.star, color: Colors.yellow.withOpacity(0.7)),
    );
  }

  Widget _ordinaryRoomBackground() {
    return Container(
      color: Colors.grey,
    );
  }

  Widget _endRoomBackground() {
    return Container(
      color: Colors.grey,
      child: Icon(Icons.flag, color: Colors.green.withOpacity(0.7)),
    );
  }
}
