import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong/ball.dart';
import 'package:pong/brick.dart';
import 'package:pong/coverscreen.dart';
import 'package:pong/scorescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  bool isgamestarted = false;
  double brickwidth = 0.4;
  double ballX = 0;
  double ballY = 0;
  double playerxtwo = 0;
  var ballYdirection = direction.DOWN;
  var ballXdirection = direction.LEFT;
  double enemyX = -0.2;
  int enemyScore = 0;
  int playerScore = 0;

  void startGame() {
    Timer.periodic(
      const Duration(milliseconds: 1),
      (timer) {
        isgamestarted = true;
        updateDirection();
        moveBall();
        moveEnemy();
        if (isPlayerOut()) {
          enemyScore++;
          timer.cancel();
          _showDialog(false);
        }
        if (isEnemyDead()) {
          playerScore++;
          timer.cancel();
          _showDialog(true);
        }
      },
    );
  }

  bool isEnemyDead() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: enemyDied
                      ? const Text(
                          'PINK Win',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'PURPLE Win',
                          style: TextStyle(color: Colors.white),
                        )),
              actions: [
                GestureDetector(
                    onTap: () {
                      resetGame();
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            color: enemyDied
                                ? Colors.pink[100]
                                : Colors.deepPurple[100],
                            padding: const EdgeInsets.all(7),
                            child: Text('Play Again',
                                style: TextStyle(
                                    color: enemyDied
                                        ? Colors.pink[100]
                                        : Colors.deepPurple[800])))))
              ]);
        });
  }

  bool isPlayerOut() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    isgamestarted = false;
    ballX = 0;
    ballY = 0;
    playerxtwo = -0.2;
    enemyX = -0.2;
  }

  void updateDirection() {
    //VERTICAL DIRECTION

    setState(
      () {
        if (ballY >= 0.9 &&
            playerxtwo + brickwidth >= ballX &&
            playerxtwo <= ballX) {
          ballYdirection = direction.UP;
        } else if (ballY <= -0.9) {
          ballYdirection = direction.DOWN;
        }
        //HORIZONTAL DIRECTION
        if (ballX >= 1) {
          ballXdirection = direction.LEFT;
        } else if (ballX <= -1) {
          ballXdirection = direction.RIGHT;
        }
      },
    );
  }

  void moveBall() {
    setState(
      () {
        //VERTICAL MOVEMENT
        if (ballYdirection == direction.DOWN) {
          ballY += 0.01;
        } else if (ballYdirection == direction.UP) {
          ballY -= 0.01;
        }
        //HORIZONTAL DIRECTION
        if (ballXdirection == direction.LEFT) {
          ballX -= 0.01;
        } else if (ballXdirection == direction.RIGHT) {
          ballX += 0.01;
        }
      },
    );
  }

  void moveLeft() {
    setState(() {
      if (!(playerxtwo - 0.1 <= -1)) {
        playerxtwo -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerxtwo + brickwidth >= 1)) {
        playerxtwo += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: () {
          startGame();
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Stack(
            children: [
              Board(
                thisIsEnemy: true,
                boardX: enemyX,
                boardY: -0.97,
                brickwidth: brickwidth,
              ),
              //score screen

              ScoreScreen(
                  gameHasStarted: isgamestarted,
                  enemyScore: enemyScore.toString(),
                  playerScore: playerScore.toString()),
              Board(
                thisIsEnemy: false,
                boardX: playerxtwo,
                boardY: 0.97,
                brickwidth: brickwidth,
              ),

              Ball(
                ballX: ballX,
                ballY: ballY,
                gameHasStarted: isgamestarted,
              ),
              CoverScreen(
                gameHasStarted: isgamestarted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
