import 'dart:math';

import 'package:flutter/material.dart';

import 'maze_room.dart';
import 'types.dart';

class Maze extends ChangeNotifier {
  //Pokoje reprezentowane jako liczby całkowite
  late final List<int> _roomIntRepList;

  final Extent extent;

  MazeRoom get startingRoom => rooms.firstWhere((e) => e.isStartingRoom);
  MazeRoom get endRoom => rooms.firstWhere((e) => e.isEndRoom);

  //Zwróć listę jako obiekty Pokoi
  //Zakładamy że pokoje w liście są ułożone wierszami tj.[ [wiersz1], [wiersz2] ] itd.
  //Przypisz do każdego pokoju odpowiadającą mu lokację (poprzez podwójną pętlę)
  List<MazeRoom> get rooms {
    return [
      for (var i = 0; i < extent.w; i++)
        for (var j = 0; j < extent.h; j++)
          MazeRoom.fromBitFlags((x: j, y: i), _roomIntRepList[i * extent.w + j])
    ];
  }

  //Zwróć listę jako obiekty Pokoi, ułożone w siatkę 2D (dla wygody indeksowania)
  List<List<MazeRoom>> get roomsGrid {
    var r = rooms;
    return [
      for (var i = 0; i < extent.w; i++)
        [for (var j = 0; j < extent.h; j++) r[i * extent.w + j]]
    ];
  }

  factory Maze.sample() {
    const List<int> list = [
      10, 8, 10, 9,
      28, 1, 0, 12,
      12, 10, 9, 13,
      6, 5, 6, 5
    ];

    return Maze.fromIntList((w: 4, h: 4), list);
  }

  Maze.random(this.extent) {
    var rng = Random();

    //Nie generuj koordynatów dla pokoi, i tak zostaną one zamienione na reprezentację intową
    _roomIntRepList = List.generate(
        extent.w * extent.h, (idx) => MazeRoom.random((x: -1, y: -1)).intValue);

    //Losuj lokację pokoju startowego (indeks w tablicy 1D dla ułatwienia)
    //Zamień na reprezentację modelu, zmodyfikuj, po czym przypisz z powrotem
    int startIdx = rng.nextInt(_roomIntRepList.length);
    var roomToModifyStart = MazeRoom.fromBitFlags((x: -1, y: -1), _roomIntRepList[startIdx]);
    roomToModifyStart.isStartingRoom = true;
    _roomIntRepList[startIdx] = roomToModifyStart.intValue;

    //Losuj lokację pokoju końcowego (indeks w tablicy 1D dla ułatwienia)
    int endIdx = rng.nextInt(_roomIntRepList.length);
    var roomToModifyEnd = MazeRoom.fromBitFlags((x: -1, y: -1), _roomIntRepList[startIdx]);
    roomToModifyEnd.isEndRoom = true;
    _roomIntRepList[endIdx] = roomToModifyEnd.intValue;
  }

  Maze.fromIntList(this.extent, this._roomIntRepList);
}
