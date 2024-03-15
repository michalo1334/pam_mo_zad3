import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/view/maze_room_minimap_widget.dart';

import '../model/maze.dart';

class MazeMinimapWidget extends StatefulWidget {
  final Maze maze;

  const MazeMinimapWidget({super.key, required this.maze});

  @override
  State<StatefulWidget> createState() => _MazeMinimapWidgetState();
}

class _MazeMinimapWidgetState extends State<MazeMinimapWidget> {
  Maze get maze => widget.maze;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: maze.extent.w,
      children: maze.rooms.map((e) => MazeRoomMinimapWidget(room: e)).toList()
    );
  }
}