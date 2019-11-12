import 'package:flutter/material.dart';

const dartSvg = "assets/dart.svg";
const flutterSvg = "assets/flutter.svg";
const penguinSvg = "assets/penguin.svg";
const reactSvg = "assets/rocket.svg";
const rocketSvg = "assets/rocket.svg";
const vscodeSvg = "assets/vscode.svg";

const String concentration = "Concentration";

class Concentration extends StatefulWidget {
  @override
  _ConcentrationState createState() => _ConcentrationState();
}

class _ConcentrationState extends State<Concentration> {
  @override
  void initState() {
    super.initState();
  }

  List<String> cards = <String> [dartSvg, flutterSvg, penguinSvg, reactSvg, rocketSvg, vscodeSvg ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
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
