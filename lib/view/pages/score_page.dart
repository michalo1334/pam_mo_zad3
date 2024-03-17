import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/model/game_session.dart';

class ScorePage extends StatelessWidget {
  final GameSession gameSession;

  const ScorePage({super.key, required this.gameSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("s"),
      ),
      body: Center(child: Text("koniec gry!"))
    );
  }

}