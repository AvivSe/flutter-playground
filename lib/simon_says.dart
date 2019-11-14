import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playground/GameWrapper.dart';

import 'home_page.dart';

const simonSays = "Simon Says";

const secondaryColors = [
  Color(0xFFffb362),
  Color(0xFFfeda6a),
  Color(0xFFf07171),
  Color(0xFF59cfcd),
];

class SimonSays extends StatefulWidget {
  @override
  _SimonSaysState createState() => _SimonSaysState();
}

class _SimonSaysState extends State<SimonSays> {
  List<Color> simonColors;
  final AudioCache player = new AudioCache();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    simonColors = <Color>[];
    simonColors.addAll(colors);

  }

  double getAngle(i) {
    switch (i) {
      case 1:
        return pi / 2;
      case 2:
        return 199.5;
      case 3:
        return pi;

      default:
        return 0;
    }
  }

  void handleColumnPress(int i) {
    setState(() {
      player.play("simon" + (i + 1).toString() + ".mp3");
      simonColors[i % simonColors.length] =
          secondaryColors[i % secondaryColors.length];
      print("tap " + i.toString());
    });
    Future.delayed(Duration(milliseconds: 300)).then((data) => setState(() =>
        simonColors[i % simonColors.length] = colors[i % simonColors.length]));
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      gameName: simonSays,
      stage: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.all(Radius.circular(2000))),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.0),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, i) {
                return Padding(
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () => this.handleColumnPress(i),
                      child: Transform.rotate(
                        angle: this.getAngle(i),
                        child: SvgPicture.asset(
                          "assets/simon.svg",
                          color: simonColors[i % colors.length],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
