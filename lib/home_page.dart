import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playground/simon_says.dart';
import 'package:playground/tic_tac_toe.dart';
import 'package:playground/concentration.dart';
import 'package:playground/zoomable_widget.dart';

import 'navi.dart';

const createdBy = "created by: avivsegal@gmail.com";

const List<String> games = <String>[
  ticTacToe,
  concentration,
  simonSays,
  createdBy,
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
  Map<String, Widget> widgetMap;

  _HomePageState() {
    widgetMap = Map();
    widgetMap.putIfAbsent(ticTacToe, () => TicTacToe());
    widgetMap.putIfAbsent(concentration, () => Concentration());
    widgetMap.putIfAbsent(simonSays, () => SimonSays());
    widgetMap.putIfAbsent(createdBy, () => SimonSays());
  }

  Column renderGameMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.0),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            itemCount: games.length,
            itemBuilder: (context, i) => SizedBox(
              child: RaisedButton(
                  shape: RoundedRectangleBorder(),
                  color: colors[i % colors.length],
                  onPressed: () => Navi.goto(context, this.widgetMap[games[i]]),
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: Text(
                      games[i],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900),
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
        body: ZoomableWidget(
          child: Container(
              child: Transform.translate(
                  offset: Offset(-110, 150),
                  child: Transform.rotate(
                      angle: pi / 4, child: renderGameMenu()))),
        ));
  }
}
