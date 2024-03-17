import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/model/game_session.dart';
import 'package:pam_mo_zad3/view/maze_room_fullscreen_widget.dart';

import 'score_page.dart';

class GamePage extends StatefulWidget {
  final GameSession gameSession;

  const GamePage({super.key, required this.gameSession});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameSession get gameSession => widget.gameSession;

  @override
  void initState() {

    gameSession.addListener(() {
      if(gameSession.finished) {
        _navigateToScorePage();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labirynt"),
      ),
      body: ListenableBuilder(
          listenable: gameSession,
          builder: (context, child) {
            return MazeRoomFullScreenWidget(
                room: gameSession.currentRoom, gameSession: gameSession);
          }),
    );
  }

  void _navigateToScorePage() async {
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScorePage(gameSession: gameSession)));
  }
}
