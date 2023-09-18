import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:number_connection_test/game/board_setting.dart';
import 'package:number_connection_test/game/game_board.dart';
import 'package:number_connection_test/game/rough_grid.dart';
import 'dart:math';

class GameView extends StatefulWidget {
  const GameView({
    super.key,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final BoardSetting _boardSetting = const BoardSetting(5, 5, 5);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _pressedFlag = false;
    double range = 100;
    var randomPicker = List<int>.generate(range.toInt(), (i) => i + 1)
      ..shuffle();
    int num;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please connect number in order!'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(
              maxHeight: 700, maxWidth: 800, minWidth: 400, minHeight: 400),
          margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 50),
          child: Column(
            // children: [Board(key: const Key('main board'), setting: _boardSetting)],
            children: [
              for (var y = 0; y < pow(range, 0.5); y++)
                Expanded(
                  child: Row(
                    children: [
                      for (var x = 0; x < pow(range, 0.5); x++)
                        if (randomPicker.isNotEmpty)
                          if ((num = randomPicker.removeLast().toInt()) < 20)
                            Expanded(
                                child: FilledButton(
                              style: FilledButton.styleFrom(
                                alignment: const Alignment(0.0, 0.0),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    _pressedFlag ? Colors.red : Colors.green,
                                // disabledBackgroundColor: Colors.red,
                                // disabledForegroundColor: Colors.white,
                              ),
                              child: Text(
                                num.toString(),
                              ),
                              // child: const SizedBox.shrink(),
                              onPressed: () {},
                              onLongPress: () {
                                setState(() => _pressedFlag = !_pressedFlag);
                              },
                            ))
                          else
                            const Expanded(child: SizedBox.shrink())
                        else
                          const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
