import 'package:flutter/material.dart';

import 'instruction.dart';
import 'navi.dart';

class GameWrapper extends StatelessWidget {
  final String gameName;
  final Widget stage;
  GameWrapper({this.gameName, this.stage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(this.gameName),
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.help_outline),
            tooltip: 'How to play?',
            onPressed: () =>
                Navi.goto(context, Instructions(gameName: this.gameName)),
          ),
        ],
      ),
      body: this.stage,
    );
  }
}
