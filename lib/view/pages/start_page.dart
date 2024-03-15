import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/model/game_session.dart';

import '../../model/maze.dart';
import 'game_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var defaultMazeData = (
    intRooms: <int>[10, 8, 10, 9, 28, 1, 0, 12, 12, 10, 9, 13, 6, 5, 6, 5],
    extent: (w: 4, h: 4)
  );

  Maze get defaultMaze =>
      Maze.fromIntList(defaultMazeData.extent, defaultMazeData.intRooms);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GamePage(gameSession: GameSession.newSession(defaultMaze))));
      },
      child: Text('Nowa gra na domyślnej mapie'),
    ));
  }
}
