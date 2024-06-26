import 'dart:math';

import 'package:flutter/material.dart';

import 'types.dart';

//Ważna rzecz: obiekty MazeRoom w klasie Maze są przechowywane w formie intów i tylko dla potrzeby wygodnego modelowania są konwertowane na tą klasę
//Dlatego gdy modyfikujemy obiekty MazeRoom należy jawnie przypisać do inta nową wartość tj.

//var room = MazeRoom.fromBitFlags(listaPokoiInt[0])
//jakieś operacje np. room.isEndRoom = true;
//aktualizujemy pod indeksem
//listaPokoiInt[0] = room.intValue
class MazeRoom extends ChangeNotifier {
  int _flags = 0;

  Location location;

  int get intValue => _flags;

  //Useful getters
  bool get hasLeftDoor => MazeRoomFlags.hasLeftDoor.extractFlag(_flags);

  bool get hasRightDoor => MazeRoomFlags.hasRightDoor.extractFlag(_flags);

  bool get hasUpperDoor => MazeRoomFlags.hasUpperDoor.extractFlag(_flags);

  bool get hasLowerDoor => MazeRoomFlags.hasLowerDoor.extractFlag(_flags);

  bool get isStartingRoom => MazeRoomFlags.isStartingRoom.extractFlag(_flags);

  bool get isEndRoom => _flags == 0;

  bool get isOrdinaryRoom => !isEndRoom || isStartingRoom;

  //Useful setters
  set hasLeftDoor(bool value) {
    _flags = MazeRoomFlags.hasLeftDoor.withChangedFlag(_flags, value);
    notifyListeners();
  }

  set hasRightDoor(bool value) {
    _flags = MazeRoomFlags.hasRightDoor.withChangedFlag(_flags, value);
    notifyListeners();
  }

  set hasUpperDoor(bool value) {
    _flags = MazeRoomFlags.hasUpperDoor.withChangedFlag(_flags, value);
    notifyListeners();
  }

  set hasLowerDoor(bool value) {
    _flags = MazeRoomFlags.hasLowerDoor.withChangedFlag(_flags, value);
    notifyListeners();
  }

  set isStartingRoom(bool value) {
    _flags = MazeRoomFlags.isStartingRoom.withChangedFlag(_flags, value);
    notifyListeners();
  }

  set isEndRoom(bool value) {
    _flags = value ? 0 : _flags;
  }

  MazeRoom(this.location) : _flags = 0;

  MazeRoom.fromBitFlags(this.location, this._flags);

  MazeRoom.random(this.location,
      {required Extent mazeExtent, bool startingRoom = false}) {
    var rng = Random();

    //Na krawędziach nie może być drzwi
    hasLeftDoor = location.x == 0 ? false : rng.nextBool();
    hasRightDoor = location.x == mazeExtent.w - 1? false : rng.nextBool();
    hasUpperDoor = location.y == 0 ? false : rng.nextBool();
    hasLowerDoor = location.y == mazeExtent.h - 1 ? false : rng.nextBool();

    //By nie było niechcianych pokoi końcowych
    //Końcowy jest ręcznie ustawiany z Maze'a
    if (isEndRoom) {
      //ustaw pierwsze lepsze, byle nie na krawędzi
      if(location.x != 0)
        hasLeftDoor = true;
      else if(location.x != mazeExtent.w - 1)
        hasRightDoor = true;
      else if(location.y != 0)
        hasUpperDoor = true;
      else if(location.y != mazeExtent.h - 1)
        hasLowerDoor = true;
    }

    isStartingRoom = startingRoom;
  }
}

enum MazeRoomFlags {
  hasLeftDoor(0),
  hasRightDoor(1),
  hasUpperDoor(2),
  hasLowerDoor(3),
  isStartingRoom(4);

  final int bitPosition;

  const MazeRoomFlags(this.bitPosition);

  //Extract bit value from the integer
  bool extractFlag(int flags) => (flags & (1 << bitPosition)) != 0;

  //Return input integer with set/reset bit value
  int withChangedFlag(int flags, bool value) =>
      (flags & ~(1 << bitPosition)) | ((value ? 1 : 0) << bitPosition);
}
