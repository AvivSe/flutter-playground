import 'package:flutter/material.dart';
import 'package:playground/GameWrapper.dart';
import 'dart:math';

import 'package:playground/home_page.dart';

const String ticTacToe = "Tic Tac Toe";

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  _State state;
  List<int> winingPath;
  int turnsCounter;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    state = _State.getInitialState(3);
    turnsCounter = 0;
  }

  void onColumnPressed(int index) {
    setState(() {
      _Column column = state.columns[index];
      bool turnX = state.turn % 2 == 0;
      if (column.enabled && !state.locked) {
        turnsCounter++;
        column.enabled = false;
        column.backgroundColor = colors[((state.turn % 2) + 2) % colors.length];
        column.text = turnX ? "X" : "O";
        winingPath = _State.isWinningMove(state, index);
        if (winingPath == null) {
          state.turn = (state.turn + 1) % state.players.length;
        } else {
          state.lock();
        }
      }
    });
  }

  void handleStartOver() {
    setState(() {
      init();
      winingPath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool someOneWon = winingPath != null;
    bool gameOver = turnsCounter == state.columns.length;
    bool startOver = someOneWon || gameOver;

    String actionText = state.getCurrentPlayerName() + ", It's your turn.";
    if (winingPath != null) {
      actionText = state.getCurrentPlayerName() + " is the winner!";
    } else if (turnsCounter == state.columns.length) {
      actionText = "Game Over.";
    }

    return GameWrapper(
        gameName: ticTacToe,
        stage: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: state.size,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                padding: const EdgeInsets.all(10.0),
                itemCount: state.columns.length,
                itemBuilder: (context, i) => SizedBox(
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () => onColumnPressed(i),
                    child: Text(
                      state.columns[i].text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 100.0 * 3 / state.size,
                          fontFamily: 'YeonSung'),
                    ),
                    color: state.columns[i].backgroundColor,
                    disabledColor: state.columns[i].backgroundColor,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                actionText,
                style: TextStyle(
                    fontSize: 30.0,
                    color: colors[(state.turn + 2) % colors.length],
                    fontFamily: 'YeonSung'),
                textAlign: TextAlign.center,
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

class _Column {
  final int id;
  String text;
  Color backgroundColor;
  bool enabled;

  _Column({this.id, this.text = "", this.backgroundColor, this.enabled = true});
}

class _State {
  int size;
  List<_Column> columns;
  List<String> players;
  int turn;
  bool winMove;
  bool locked;

  String getCurrentPlayerName() {
    return players[turn];
  }

  static _State getInitialState(int size) {
    _State initialState = _State();
    initialState.columns = <_Column>[];
    initialState.players = <String>["Player One", "Player Two"];
    initialState.turn = 0;
    initialState.locked = false;
    initialState.size = size;

    for (int i = 0; i < pow(size, 2); i++) {
      initialState.columns
          .add(_Column(id: i, backgroundColor: Colors.grey[850]));
    }

    return initialState;
  }

  void lock() {
    this.locked = true;
  }

  static List<int> isWinningMove(_State state, index) {
    _Column column = state.columns[index];
    bool turnX = state.turn % 2 == 0;
    int boardSize = state.size;
    // Winner test
    int x = (index / boardSize).floor();
    int y = index % boardSize;

    bool win = true;
    List<int> winnerPath = <int>[];

    // test row:
    for (int i = boardSize * x; i < boardSize * (x + 1); i++) {
      winnerPath.add(i);
      if (state.columns[i].text != column.text) {
        win = false;
        winnerPath.clear();
        break;
      }
    }

    if (!win) {
      win = true;
      for (int i = index % boardSize;
          i < state.columns.length;
          i += boardSize) {
        winnerPath.add(i);
        if (state.columns[i].text != column.text) {
          win = false;
          winnerPath.clear();
          break;
        }
      }
    }

    // test left diagonal
    if (!win && x == y) {
      win = true;
      for (int i = 0; i < state.columns.length; i += boardSize + 1) {
        winnerPath.add(i);
        if (state.columns[i].text != column.text) {
          win = false;
          winnerPath.clear();
          break;
        }
      }
    }

    // test right diagonal
    if (!win) {
      win = true;
      for (int i = boardSize - 1;
          i < state.columns.length - boardSize + 1;
          i += boardSize - 1) {
        winnerPath.add(i);
        if (state.columns[i].text != column.text) {
          win = false;
          winnerPath.clear();
          break;
        }
      }
    }

    if (win) {
      print((turnX ? "X" : "O") + " Win! " + winnerPath.toString());
      return winnerPath;
    }

    return null;
  }
}
