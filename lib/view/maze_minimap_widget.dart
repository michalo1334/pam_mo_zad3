import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/model/game_session.dart';
import 'package:vector_math/vector_math_64.dart';
import '/view/maze_room_minimap_widget.dart';
import '../model/maze.dart';

class MazeMinimapWidget extends StatefulWidget {
  final Maze maze;
  final GameSession? gameSession;

  const MazeMinimapWidget({super.key, required this.maze, this.gameSession});

  @override
  State<StatefulWidget> createState() => _MazeMinimapWidgetState();
}

class _MazeMinimapWidgetState extends State<MazeMinimapWidget> {
  Maze get maze => widget.maze;
  GameSession? get gameSession => widget.gameSession;

  @override
  Widget build(BuildContext context) {
    if(gameSession == null) {
      return _build();
    }
    else {
      return ListenableBuilder(listenable: gameSession!, builder: (context, child) => _build());
    }
  }

  Column _build() {
    return Column(
      children: [
        ElevatedButton(onPressed: () {gameSession?.moveThroughBottomDoor();}, child: Text("W dół")),
        ElevatedButton(onPressed: () {gameSession?.moveThroughTopDoor();}, child: Text("W góre")),
        ElevatedButton(onPressed: () {gameSession?.moveThroughLeftDoor();}, child: Text("W lewo")),
        ElevatedButton(onPressed: () {gameSession?.moveThroughRightDoor();}, child: Text("W prawo")),
        AspectRatio(
          aspectRatio: 1,
          child: Transform(
            transform: Matrix4.translation(Vector3(0, 0, 0)),
            child: GridView.count(
                crossAxisCount: maze.extent.w,
              children: maze.rooms.map((e) => MazeRoomMinimapWidget(room: e, gameSession: gameSession)).toList()
            ),
          ),
        ),
      ],
    );
  }
}