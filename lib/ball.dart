import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({
    Key? key,
    required this.ballX,
    required this.ballY,
    required this.gameHasStarted,
  }) : super(key: key);
  final double ballX;
  final double ballY;
  final bool gameHasStarted;

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              width: MediaQuery.of(context).size.width / 22,
              height: MediaQuery.of(context).size.width / 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent,
              ),
            ))
        : Container(
            alignment: Alignment(0, 0),
            child: AvatarGlow(
              endRadius: 60,
              child: Material(
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: 30,
                    height: 30,
                  ),
                  radius: 7.0,
                ),
              ),
            ),
          );
  }
}
