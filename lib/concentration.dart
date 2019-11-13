import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

const dart = "dart";
const flutter = "flutter";
const penguin = "penguin";
const react = "react";
const rocket = "rocket";
const vscode = "vscode";

const String concentration = "Concentration";

class Concentration extends StatefulWidget {
  @override
  _ConcentrationState createState() => _ConcentrationState();
}

class _ConcentrationState extends State<Concentration> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  List<String> cards;
  Set<String> resolvedCards;
  int exposedCard;
  int secondaryExposedCard;
  var subscription;

  void _init() {
    cards = <String>[
      dart,
      flutter,
      penguin,
      react,
      rocket,
      vscode,

      // same as above:
      dart,
      flutter,
      penguin,
      react,
      rocket,
      vscode
    ];
    cards.shuffle();
    exposedCard = -1;
    secondaryExposedCard = -1;
    resolvedCards = HashSet();
  }

  handleStartOver() {
    setState(() {
      _init();
    });
  }

  handleCardPress(i) {
    int delayMs = 2000;
    if (secondaryExposedCard == -1 && resolvedCards.length != cards.length) {
      if (subscription != null) {
        subscription.cancel();
      }

      setState(() {
        if (exposedCard != -1) {
          if (cards[i] == cards[exposedCard]) {
            resolvedCards.add(cards[i]);
            secondaryExposedCard = -1;
            exposedCard = -1;
          }
          delayMs = 800;
        }
        subscription = Future.delayed(Duration(milliseconds: delayMs))
            .asStream()
            .listen((data) {
          setState(() {
            secondaryExposedCard = -1;
            exposedCard = -1;
          });
        });

        secondaryExposedCard = exposedCard;
        exposedCard = i;
      });
    }
  }

  Widget renderCard(int i) {
    Widget widget;

    if (resolvedCards.contains(cards[i]) ||
        exposedCard == i ||
        secondaryExposedCard == i) {
      widget = SvgPicture.asset("assets/" + cards[i] + ".svg");
    } else {
      widget = RaisedButton(
        padding: const EdgeInsets.all(8.0),
        onPressed: () => handleCardPress(i),
        color: Colors.grey[850],
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    bool startOver = resolvedCards.length == cards.length;

    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(concentration),
          backgroundColor: Colors.grey[900],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                padding: const EdgeInsets.all(5.0),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                itemCount: cards.length,
                itemBuilder: (context, i) => SizedBox(
                  child: renderCard(i),
                ),
              ),
            ),
            RaisedButton(
              onPressed: handleStartOver,
              color: startOver ? Colors.lightGreen : colors[2 % colors.length],
              padding: EdgeInsets.all(startOver ? 5.0 : 0.0),
              child: Text(
                "Start Over",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: startOver ? 50.0 : 25.0,
                    fontFamily: 'YeonSung'),
              ),
            ),
          ],
        ));
  }
}
