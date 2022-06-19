import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen(
      {Key? key,
      required this.gameHasStarted,
      required this.enemyScore,
      required this.playerScore})
      : super(key: key);
  final String enemyScore;
  final bool gameHasStarted;
  final String playerScore;
  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Stack(children: [
            Container(
                alignment: Alignment(0, 0),
                child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 3,
                    color: Colors.grey[500])),
            Container(
                alignment: Alignment(0, 0.25),
                child: Container(
                  child: Text(playerScore,
                      style: TextStyle(fontSize: 100, color: Colors.grey[700])),
                )),
            Container(
                alignment: Alignment(0, -0.25),
                child: Container(
                  child: Text(enemyScore,
                      style: TextStyle(fontSize: 100, color: Colors.grey[700])),
                ))
          ])
        : Container();
  }
}
