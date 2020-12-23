import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final int size;
  const Game({Key key, this.size = 16}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<GlobalKey<FlipCardState>> cardStateKeys;
  List<String> data;
  List<bool> isCardFlip;
  bool flip;

  int previousIndex;

  int time;
  Timer timer;

  void initStateHere() {
    // cardStateKeys.clear();
    // data.clear();
    // isCardFlip.clear();

    cardStateKeys = [];
    data = [];
    isCardFlip = [];
    flip = false;
    previousIndex = -1;
    time = 0;

    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      isCardFlip.add(true);
    }

    for (var i = 0; i < 2; i++) {
      for (var j = 0; j < widget.size / 2; j++) {
        data.add(j.toString());
      }
    }
    startTimer();
    data.shuffle();
  }

  void initState() {
    super.initState();
    initStateHere();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Theme(
              data: ThemeData.dark(),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 175.0, horizontal: 15.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) => FlipCard(
                          key: cardStateKeys[index],
                          onFlip: () {
                            if (flip) {
                              flip = false;
                              if (data[previousIndex] != data[index]) {
                                cardStateKeys[previousIndex]
                                    .currentState
                                    .toggleCard();
                                previousIndex = index;
                              } else {
                                isCardFlip[previousIndex] = false;
                                isCardFlip[index] = false;
                              }
                              if (isCardFlip
                                  .every((element) => element == false)) {
                                initStateHere();
                              }
                            } else {
                              flip = true;
                              previousIndex = index;
                            }
                          },
                          direction: FlipDirection.HORIZONTAL,
                          flipOnTouch: isCardFlip[index],
                          front: Container(
                            margin: EdgeInsets.all(5.0),
                            child: Image.asset("assets/cover.png"),
                          ),
                          back: Container(
                            margin: EdgeInsets.all(5.0),
                            //color: Colors.grey,
                            child: Center(
                              child: Image.asset(
                                  "assets/" + "${data[index]}" + ".png"),
                            ),
                          ),
                        ),
                    itemCount: data.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
