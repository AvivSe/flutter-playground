import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  final String gameName;
  Instructions({this.gameName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Learn how to play " + gameName),
          backgroundColor: Colors.grey[900],
        ),
        body: Container());
  }
}
