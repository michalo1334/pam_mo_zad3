import 'package:flutter/material.dart';

import 'maze.dart';
import 'maze_room.dart';
import 'types.dart';

class GameSession extends ChangeNotifier {
  bool _finished = false;

  bool get finished => _finished;

  set finished(bool value) {
    _finished = value;
    if(_finished) stopwatch.stop();
    notifyListeners();
  }

  final Maze maze;

  //Gdzie jest gracz
  MazeRoom _currentRoom;

  //Statystyki
  int visitedRooms = 0;
  Duration elapsedTime = Duration.zero;
  Stopwatch stopwatch;

  MazeRoom get currentRoom => _currentRoom;

  set currentRoom(MazeRoom value) {
    _currentRoom = value;
    notifyListeners();
  }

  Location get currentLocation => currentRoom.location;

  bool get isInFinalRoom => currentRoom.location == maze.endRoom.location;

  GameSession.newSession(this.maze)
      : _currentRoom = maze.startingRoom,
      stopwatch = Stopwatch()..start();

  void moveThroughLeftDoor() {
    if (currentRoom.hasLeftDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y][currentLocation.x - 1];

      finished = isInFinalRoom;
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughRightDoor() {
    if (currentRoom.hasRightDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y][currentLocation.x + 1];

      finished = isInFinalRoom;
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughTopDoor() {
    if (currentRoom.hasUpperDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y - 1][currentLocation.x];

      finished = isInFinalRoom;
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughBottomDoor() {
    if (currentRoom.hasLowerDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y + 1][currentLocation.x];

      finished = isInFinalRoom;
      visitedRooms++;
      notifyListeners();
    }
  }

  void finishSession() {
    finished = true;
  }
}
