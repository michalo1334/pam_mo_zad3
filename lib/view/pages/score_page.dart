import 'package:flutter/material.dart';
import 'package:pam_mo_zad3/model/game_session.dart';

import 'start_page.dart';

class ScorePage extends StatelessWidget {
  final GameSession gameSession;

  const ScorePage({super.key, required this.gameSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Labiryncik"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Koniec gry!"),
              gameSession.won ? Text("Wygrałeś! 😎") : Text("Przegrałeś! 😭"),
              Text("Czas: ${gameSession.stopwatch.elapsed.toString()}"),
              Text("Odwiedzone komnaty: ${gameSession.visitedRooms}"),
              ElevatedButton(
                onPressed: () => _navigateToStartPage(context),
                child: Text("Powrót"),
              ),
            ],
          ),
        ));
  }

  void _navigateToStartPage(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) => StartPage()));
  }
}
