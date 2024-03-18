import 'dart:convert';

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
  int w = 4;
  int h = 4;
  String listString = "[]";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text('Labiryncik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDefaultGameButton(),
            _buildGeneratedMazeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultGameButton() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Center(
          child: ElevatedButton(
            onPressed: () =>
                _navigateToGamePage(GameSession.newSession(Maze.sample())),
            child: const Text('Nowa gra na domyślnej mapie'),
          )),
    );
  }

  Widget _buildGeneratedMazeButton() {
    var button = Padding(
      padding: const EdgeInsets.all(3),
      child: Center(
          child: ElevatedButton(
            onPressed: () =>
                _navigateToGamePage(
                    GameSession.newSession(Maze.random((w: w, h: h)))),
            child: const Text('Nowa gra na losowej mapie o podanym rozmiarze'),
          )),
    );

    var fieldW = TextField(
        decoration: const InputDecoration(labelText: 'Szerokość'),
        keyboardType: TextInputType.number,
        onChanged: (value) => w = int.parse(value)
    );
    var fieldH = TextField(
        decoration: const InputDecoration(labelText: 'Wysokość'),
        keyboardType: TextInputType.number,
        onChanged: (value) => h = int.parse(value)
    );

    return FractionallySizedBox(
      widthFactor: 0.4,
      child: Column(
        children: [
          button,
          fieldW,
          fieldH,
        ],
      ),
    );
  }

  Widget _buildTemplateMazeButton() {
    var button = Padding(
        padding: const EdgeInsets.all(3),
        child: Center(
          child: ElevatedButton(
              onPressed: () =>
                  _navigateToGamePage(GameSession.newSession(Maze.fromIntList(
                      (w: w, h: h), jsonDecode(listString).cast<int>()))),
              child: const Text('Nowa gra na podanej mapie'),
        ))
    ,);

    var fieldW = TextField(
    decoration: const InputDecoration(labelText: 'Szerokość'),
    keyboardType: TextInputType.number,
    onChanged: (value) => w = int.parse(value)
    );
    var fieldH = TextField(
    decoration: const InputDecoration(labelText: 'Wysokość'),
    keyboardType: TextInputType.number,
    onChanged: (value) => h = int.parse(value)
    );

    var fieldList = TextField(
    decoration: const InputDecoration(labelText: 'Lista liczb'),
    keyboardType: TextInputType.multiline,
    onChanged: (value) => listString = value
    );

    return FractionallySizedBox(
    widthFactor: 0.4,
    child: Column(
    children: [
    button,
    fieldW,
    fieldH,
    fieldList,
    ],
    ),
    );

  }

  void _navigateToGamePage(GameSession session) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GamePage(gameSession: session)));
  }
}
