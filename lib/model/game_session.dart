import 'package:flutter/material.dart';

import 'maze.dart';
import 'maze_room.dart';
import 'types.dart';

class GameSession extends ChangeNotifier {
  bool _finished = false;
  bool _won = false;

  bool get won => _won;

  set won(bool value) {
    _won = value;
    notifyListeners();
  }

  bool get finished => _finished;

  set finished(bool value) {
    _finished = value;
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

      finishIfInFinalRoom();
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughRightDoor() {
    if (currentRoom.hasRightDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y][currentLocation.x + 1];

      finishIfInFinalRoom();
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughTopDoor() {
    if (currentRoom.hasUpperDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y - 1][currentLocation.x];

      finishIfInFinalRoom();
      visitedRooms++;
      notifyListeners();
    }
  }

  void moveThroughBottomDoor() {
    if (currentRoom.hasLowerDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y + 1][currentLocation.x];

      finishIfInFinalRoom();
      visitedRooms++;
      notifyListeners();
    }
  }

  void finishSession({bool win = true}) {
    finished = true;

    won = win;
    stopwatch.stop();
  }

  void finishIfInFinalRoom() {
    if(isInFinalRoom) finishSession(win: true);
  }
}
