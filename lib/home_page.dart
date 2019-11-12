import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playground/tic_tac_toe.dart';
import 'package:playground/concentration.dart';


const List<String> games = <String>[
  ticTacToe,
  concentration,
  ticTacToe,
  concentration,
];

const colors = [
  Color(0xFFff9930),
  Color(0xFFfdcd39),
  Color(0xFFeb4341),
  Color(0xFF24bfbc),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Widget renderGame(String gameName) {
    switch (gameName) {
      case ticTacToe:
        return TicTacToe();
      case concentration:
        return Concentration();
      default:
        return null;
    }
  }

  static push(BuildContext context, String gameName) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => renderGame(gameName)));
  }

  Column renderGameMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              // crossAxisSpacing: 500,
              // mainAxisSpacing: 500.0
            ),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            itemCount: games.length,
            itemBuilder: (context, i) => SizedBox(
              child: RaisedButton(
                  shape: RoundedRectangleBorder(),
                  color: colors[i % colors.length],
                  onPressed: () => push(context, games[i]),
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: Text(
                      games[i],
                      style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.w900),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Container(
            child: Transform.translate(
                offset: Offset(-75, 100),
                child:
                    Transform.rotate(angle: pi / 4, child: renderGameMenu()))));
  }
}
