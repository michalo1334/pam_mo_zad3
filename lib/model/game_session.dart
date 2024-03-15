import 'package:flutter/material.dart';

import 'maze.dart';
import 'maze_room.dart';
import 'types.dart';

class GameSession extends ChangeNotifier {
  final Maze maze;
  MazeRoom _currentRoom;

  int visitedRooms = 0;
  Duration elapsedTime = Duration.zero;

  MazeRoom get currentRoom => _currentRoom;

  set currentRoom(MazeRoom value) {
    _currentRoom = value;
    notifyListeners();
  }

  Location get currentLocation => currentRoom.location;


  GameSession.newSession(this.maze)
      : _currentRoom = maze.startingRoom;

  void moveThroughLeftDoor() {
    if (currentRoom.hasLeftDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y][currentLocation.x - 1];
      notifyListeners();
    }
  }

  void moveThroughRightDoor() {
    if (currentRoom.hasRightDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y][currentLocation.x + 1];
      notifyListeners();
    }
  }

  void moveThroughTopDoor() {
    if (currentRoom.hasUpperDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y - 1][currentLocation.x];
      notifyListeners();
    }
  }

  void moveThroughBottomDoor() {
    if (currentRoom.hasLowerDoor) {
      currentRoom = maze.roomsGrid[currentLocation.y + 1][currentLocation.x];
      notifyListeners();
    }
  }
}
