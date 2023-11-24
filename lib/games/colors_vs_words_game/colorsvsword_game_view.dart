import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_connection_test/constants/routes.dart';

import 'package:number_connection_test/games/colors_vs_words_game/options_in_row.dart';
import 'package:number_connection_test/games/colors_vs_words_game/questions.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/records_service.dart';

class ColorvsWordGameView extends StatefulWidget {
  const ColorvsWordGameView({super.key});

  @override
  State<ColorvsWordGameView> createState() => _ColorvsWordGameViewState();
}

class _ColorvsWordGameViewState extends State<ColorvsWordGameView> {
  DatabaseRecords? _record;
  late final RecordsService _recordsService;
  late final _now = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now());
  late final String _gametime;
  final stopwatch = Stopwatch();
  int _currindex = 0;

  var ansIndexList = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8];
  var optionsUsedList = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8];
  var optionsIndexList = <int>[1, 2, 3, 4];
  final _random = Random();

  void checkAnswer(userAns, BuildContext context) {
    // print(userAns + wordsList[ansIndexList[_currindex]]);

    if (userAns == wordsList[ansIndexList[_currindex]]) {
      score += 1;
    }
    _currindex += 1;
    if (_currindex == ansIndexList.length) {
      // game over
      _currindex -= 1; // Prevent out-of-range errors
      Navigator.of(context)
          .pushNamedAndRemoveUntil(gameoverRoute, (_) => false);
    }
  }

  @override
  void initState() {
    _recordsService = RecordsService();
    ansIndexList.shuffle();
    stopwatch.start();
    score = 0;
    super.initState();
  }

  void _createAndSaveNewRecord() async {
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email;
    final owner = await _recordsService.getUser(email: email);
    String nowTime = _now.toString();
    final newRecord = await _recordsService.createRecord(
      owner: owner,
      timestamp: nowTime,
      gametime: _gametime,
    );
    _record = newRecord;
  }

  @override
  void setState(VoidCallback fn) {
    optionsUsedList.remove(ansIndexList[_currindex]);
    optionsUsedList.shuffle();
    optionsIndexList.clear();
    optionsIndexList = optionsUsedList.take(3).toList();
    optionsIndexList.add(ansIndexList[_currindex]);
    optionsIndexList.shuffle();
    optionsUsedList.add(ansIndexList[_currindex]);
    super.setState(fn);
  }

  @override
  void deactivate() {
    stopwatch.stop;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(stopwatch.elapsed.inMinutes.remainder(60));
    final seconds = twoDigits(stopwatch.elapsed.inSeconds.remainder(60));
    _gametime = '$minutes : $seconds';
    _createAndSaveNewRecord();
    super.deactivate();
  }

  @override
  void dispose() {
    // _recordsService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    optionsUsedList.remove(ansIndexList[_currindex]);
    optionsUsedList.shuffle();
    optionsIndexList = optionsUsedList.take(3).toList();
    optionsIndexList.add(ansIndexList[_currindex]);
    optionsIndexList.shuffle();
    optionsUsedList.add(ansIndexList[_currindex]);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 240, 219),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              /// Question Container
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Score and icons
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[900],
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  'Score: $score',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'KGB',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Question
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Question
                            Center(
                              child: Text(
                                // question is at index 0 of daques where quesinorder[quesno]
                                // is the index of question no in daques
                                wordsList[ansIndexList[_currindex]],
                                style: TextStyle(
                                  fontSize: 100.0,
                                  fontFamily: 'RussoOne',
                                  color: colorsList[ansIndexList[((_random
                                              .nextInt(colorsList.length - 1)) +
                                          (_currindex + 1)) %
                                      (colorsList.length)]],
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Answer row 1
              genrow(
                  btn1: 0,
                  btn2: 1,
                  btn1ListString: wordsList[optionsIndexList[0]],
                  btn2ListString: wordsList[optionsIndexList[1]],
                  updatestate: (String userAns) {
                    setState(() {
                      checkAnswer(userAns, context);
                    });
                  }),
              const SizedBox(height: 5.0),

              /// Answer row 2
              genrow(
                  btn1: 2,
                  btn2: 3,
                  btn1ListString: wordsList[optionsIndexList[2]],
                  btn2ListString: wordsList[optionsIndexList[3]],
                  updatestate: (String userAns) {
                    setState(() {
                      checkAnswer(userAns, context);
                    });
                  }),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
