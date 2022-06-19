import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  Board(
      {Key? key,
      required this.boardX,
      required this.boardY,
      this.brickwidth,
      this.thisIsEnemy})
      : super(key: key);

  final double boardX;
  final double boardY;
  final brickwidth;
  final thisIsEnemy;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment((2 * boardX + brickwidth) / (2 - brickwidth), boardY),
      child: Container(
        decoration: BoxDecoration(
            color: thisIsEnemy ? Colors.deepPurple[300] : Colors.pink,
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * brickwidth / 2,
        height: 20,
      ),
    );
  }
}
