import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_connection_test/game/buttons_view.dart';
import 'package:number_connection_test/game/stopwatch.dart';
import 'package:number_connection_test/globals/gobals.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.startNum, required this.endNum});
  final int startNum;
  final int endNum;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  bool gameStart = true;
  bool startStringPopUp = true;
  List<String> countDownAnimationString = [
    'Start',
    '1',
    '2',
    '3',
  ];

  @override
  Widget build(BuildContext context) {
    int range = widget.endNum - widget.startNum + 1;

    if (range <= 10) {
      range = 16;
    } else if (range > 10 && range <= 20) {
      range = 25;
    } else {
      range = 50;
    }

    // var randomLimit = range * range;
    var randomPicker = List<int>.generate(range, (startNum) => startNum + 1)
      ..shuffle();
    int num;
    gamingNumber = widget.startNum - 1;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 240, 219),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // title: gameStart
        //     ? const SizedBox()
        //     : const Text('Game!', style: TextStyle(fontSize: 25)),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // if (!gameStart) {
        //       //   setState(() {
        //       //     gameStart = true;
        //       //   });
        //       // }
        //     },
        //     icon: const Icon(Icons.play_arrow),
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            alignment: Alignment.bottomRight,
            child: PreferredSize(
                preferredSize: const Size.fromHeight(5.0),
                child: gameStart
                    ? const StopWatch(
                        start: true,
                      )
                    : const SizedBox()),
          ),
        ),
      ),
      extendBody: false,
      body: Center(
        child: Container(
            alignment: Alignment.center,
            // constraints: const BoxConstraints(
            //     maxHeight: 700, maxWidth: 800, minWidth: 400, minHeight: 400),
            margin:
                const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(10, 255, 240, 219).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: const Color.fromARGB(247, 186, 184, 184),
                width: 5.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var y = 0; y <= pow(range, 0.5); y++)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var x = 0; x <= pow(range, 0.5); x++)
                          if (randomPicker.isNotEmpty)
                            if ((num = randomPicker.removeLast().toInt()) <=
                                    widget.endNum &&
                                num >= widget.startNum)
                              Expanded(
                                child: WrapperButton(
                                  labelnum: num,
                                  endnum: widget.endNum,
                                ),
                              )
                            else
                              const Expanded(child: SizedBox.shrink())
                          else
                            const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
              ],
            )
            // : SizedBox.expand(
            //     child: Center(
            //       child: startStringPopUp
            //           ? CountDownAnimation()
            //           : Text('Start!'),
            //     ),
            //   ),
            ),
      ),
    );
  }
}
