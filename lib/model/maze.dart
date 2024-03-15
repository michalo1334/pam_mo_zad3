import 'dart:math';

import 'package:flutter/material.dart';

import 'maze_room.dart';
import 'types.dart';

class Maze extends ChangeNotifier {
  late final List<int> _roomIntRepList;

  final Extent extent;

  late final Location startingRoomLocation;
  late final Location endRoomLocation;

  List<MazeRoom> get rooms {
    return [
      for (var i = 0; i < extent.w; i++)
        for (var j = 0; j < extent.h; j++)
          MazeRoom.fromBitFlags((x: j, y: i), _roomIntRepList[i * extent.w + j])
    ];
  }

  Maze.empty()
      : extent = (w: 0, h: 0),
        _roomIntRepList = [],
        startingRoomLocation = (x: -1, y: -1),
        endRoomLocation = (x: -1, y: -1);

  Maze.random(this.extent) {
    var rng = Random();
  }

  Maze.fromIntList(this.extent, this._roomIntRepList) {
    //Find starting and end room location
    startingRoomLocation = rooms.firstWhere((e) => e.isStartingRoom).location;
    endRoomLocation = rooms.firstWhere((e) => e.isEndRoom).location;
  }
}
