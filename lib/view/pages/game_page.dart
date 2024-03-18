import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pam_mo_zad3/model/game_session.dart';
import 'package:pam_mo_zad3/view/maze_minimap_widget.dart';
import 'package:pam_mo_zad3/view/maze_room_fullscreen_widget.dart';
import 'package:pam_mo_zad3/view/maze_room_minimap_widget.dart';

import 'score_page.dart';

class GamePage extends StatefulWidget {
  final GameSession gameSession;

  final String gridHUDTemplate = """
  . . .
  . . .
  . . minimap
  """;

  const GamePage({super.key, required this.gameSession});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Timer? timer;

  GameSession get gameSession => widget.gameSession;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {setState((){});});

    gameSession.addListener(() {
      if(gameSession.finished) {
        _navigateToScorePage();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Labiryncik"),
        actions: [
          _buildGiveUpButton(),
          _buildTime(),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _buildMainLayer(),
          _buildMinimapLayer()
        ],
      )
    );
  }

  Widget _buildMainLayer() {
    return ListenableBuilder(
        listenable: gameSession,
        builder: (context, child) {
          return MazeRoomFullScreenWidget(
              room: gameSession.currentRoom, gameSession: gameSession);
        });
  }

  Widget _buildMinimapLayer() {
    return LayoutGrid(
      areas: widget.gridHUDTemplate,
        columnSizes: [1.fr, 1.fr, 1.fr],
        rowSizes: [1.fr, 1.fr, 1.fr],
      children: [
        MazeMinimapWidget(maze: gameSession.maze, gameSession: gameSession).inGridArea("minimap")
      ],
    );
  }

  Widget _buildTime() {
    return Row(
      children: [
        const Icon(Icons.timer),
        Text(_format(gameSession.stopwatch.elapsed))
      ],
    );
  }

  Widget _buildGiveUpButton() {
    return IconButton(
        onPressed: () {gameSession.finishSession(win: false); _navigateToScorePage();},
        tooltip: "Poddaj się",
        icon: const Icon(Icons.thumb_down)
    );
  }

  String _format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _navigateToScorePage() async {
    var nav = Navigator.of(context);
    await Future.delayed(const Duration(seconds: 1));

    nav.pushReplacement(MaterialPageRoute(
        builder: (context) => ScorePage(gameSession: gameSession)));
  }
}
