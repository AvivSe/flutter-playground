import 'package:flutter/material.dart';

const String concentration = "Concentration";


class Concentration extends StatefulWidget {
  @override
  _ConcentrationState createState() => _ConcentrationState();
}

class _ConcentrationState extends State<Concentration> {

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {

  }

  void onNewGamePressed() {
    setState(() {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Concentration"),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(),
    );
  }
}