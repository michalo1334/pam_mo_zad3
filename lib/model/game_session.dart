import 'package:flutter/material.dart';

import 'maze.dart';
import 'maze_room.dart';
import 'types.dart';

class GameSession extends ChangeNotifier {
  final Maze maze;
  MazeRoom currentRoom;
  Location get currentLocation => currentRoom.location;

  GameSession.newSession(this.maze) : currentRoom = maze.startingRoom;

  void moveThroughLeftDoor() {
    if (currentRoom.hasLeftDoor) {
      currentRoom = maze.roomsGrid[currentLocation.x][currentLocation.y - 1];
    }
  }
  void moveThroughRightDoor() {
    if (currentRoom.hasRightDoor) {
      currentRoom = maze.roomsGrid[currentLocation.x][currentLocation.y + 1];
    }
  }
  void moveThroughTopDoor() {
    if (currentRoom.hasUpperDoor) {
      currentRoom = maze.roomsGrid[currentLocation.x - 1][currentLocation.y];
    }
  }
  void moveThroughBottomDoor() {
    if (currentRoom.hasLowerDoor) {
      currentRoom = maze.roomsGrid[currentLocation.x + 1][currentLocation.y];
    }
  }
}