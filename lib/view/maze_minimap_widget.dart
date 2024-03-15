import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import '/view/maze_room_minimap_widget.dart';
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
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: Transform(
          transform: Matrix4.translation(Vector3(0, 0, 0)),
          child: GridView.count(
              crossAxisCount: maze.extent.w,
            children: maze.rooms.map((e) => MazeRoomMinimapWidget(room: e)).toList()
          ),
        ),
      ),
    );
  }
}