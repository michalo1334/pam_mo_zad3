import 'dart:math';

import 'package:flutter/material.dart';

import 'maze_room.dart';
import 'types.dart';

class Maze extends ChangeNotifier {
  late final List<int> _roomIntRepList;

  final Extent extent;

  late final MazeRoom startingRoom;
  late final MazeRoom endRoom;

  List<MazeRoom> get rooms {
    return [
      for (var i = 0; i < extent.w; i++)
        for (var j = 0; j < extent.h; j++)
          MazeRoom.fromBitFlags((x: j, y: i), _roomIntRepList[i * extent.w + j])
    ];
  }

  //Return list of rooms as 2D array with XY coordinates (not YX)
  List<List<MazeRoom>> get roomsGrid {
    var r = rooms;
    return [
      for (var i = 0; i < extent.w; i++)
        [for (var j = 0; j < extent.h; j++) r[i * extent.w + j]]
    ];
  }

  Maze.empty()
      : extent = (w: 0, h: 0),
        _roomIntRepList = [];

  Maze.random(this.extent) {
    var rng = Random();
  }

  Maze.fromIntList(this.extent, this._roomIntRepList) {
    //Find starting and end room location
    startingRoom = rooms.firstWhere((e) => e.isStartingRoom);
    endRoom = rooms.firstWhere((e) => e.isEndRoom);
  }
}
