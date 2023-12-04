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

  //
  int _currAnsIndex = 0;
  int _currinterferenceOptionIndex = 1;
  List ansIndexList = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8];
  List optionsUsedList = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8];
  List optionsIndexList = <int>[1, 2, 3, 4];

  void checkAnswer(userAns, bool questionType, BuildContext context) {
    // print(userAns + wordsList[ansIndexList[_currindex]]);

    if (userAns == wordsList[ansIndexList[_currAnsIndex - 1]]) {
      score += 1;
    }

    if (_currinterferenceOptionIndex == 0) {
      // game over
      Navigator.of(context)
          .pushNamedAndRemoveUntil(cwgameoverRoute, (_) => false);
    }
  }

  void handlerOptionsAndAnwser() {}

  @override
  void initState() {
    _recordsService = RecordsService();
    ansIndexList.shuffle();
    stopwatch.start();
    score = 0;
    print('new');
    print(
        "ansIndexList[_currAnsIndex] ${ansIndexList[_currAnsIndex]} ansIndexList[_currinterferenceOptionIndex]  ${ansIndexList[_currinterferenceOptionIndex]}");
    optionsUsedList.remove(ansIndexList[_currAnsIndex]);
    optionsUsedList.remove(ansIndexList[_currinterferenceOptionIndex]);
    optionsUsedList.shuffle();
    optionsIndexList.clear();
    print("clear $optionsIndexList");
    optionsIndexList = optionsUsedList.take(2).toList();
    optionsIndexList.add(ansIndexList[_currAnsIndex]);
    optionsIndexList.add(ansIndexList[_currinterferenceOptionIndex]);
    print("add ans and inter $optionsIndexList");
    optionsIndexList.shuffle();
    optionsUsedList.add(ansIndexList[_currAnsIndex]);
    optionsUsedList.add(ansIndexList[_currinterferenceOptionIndex]);
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
    _currAnsIndex += 1;
    _currinterferenceOptionIndex =
        (_currinterferenceOptionIndex + 1) % (ansIndexList.length);
    print('new');
    print(
        "ansIndexList[_currAnsIndex] ${ansIndexList[_currAnsIndex]} ansIndexList[_currinterferenceOptionIndex]  ${ansIndexList[_currinterferenceOptionIndex]}");
    optionsUsedList.remove(ansIndexList[_currAnsIndex]);
    optionsUsedList.remove(ansIndexList[_currinterferenceOptionIndex]);
    optionsUsedList.shuffle();
    optionsIndexList.clear();
    print("clear $optionsIndexList");
    optionsIndexList = optionsUsedList.take(2).toList();
    optionsIndexList.add(ansIndexList[_currAnsIndex]);
    optionsIndexList.add(ansIndexList[_currinterferenceOptionIndex]);
    print("add ans and inter $optionsIndexList");
    optionsIndexList.shuffle();
    optionsUsedList.add(ansIndexList[_currAnsIndex]);
    optionsUsedList.add(ansIndexList[_currinterferenceOptionIndex]);

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
    print(
        "ansIndexList[_currAnsIndex]: ${ansIndexList[_currAnsIndex]} ansIndexList[_currinterferenceOptionIndex]: ${ansIndexList[_currinterferenceOptionIndex]}");
    print("$optionsIndexList");

    // For both question types, the title is represented by a Chinese character denoting color,
    // harmoniously paired with a distinct background color.
    // 1. Present a selection of 4 colors, each accompanied by a background of a different hue,
    //    empowering users to discern and choose the color that aligns with the intended significance
    //    of the text in the question.
    // 2. Offer a set of 4 color words as alternatives, enabling users to align their choice
    //    with the background color of the Chinese text within the question.
    bool questionType = Random().nextBool();
    print(questionType);

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
                            questionType
                                ? const Text(
                                    '字的底色是什麼顏色',
                                    style: TextStyle(fontSize: 25),
                                  )
                                : const Text(
                                    '字的意義代表什麼顏色',
                                    style: TextStyle(fontSize: 25),
                                  ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                questionType
                                    ? wordsList[ansIndexList[
                                        _currinterferenceOptionIndex]]
                                    : wordsList[ansIndexList[_currAnsIndex]],
                                style: TextStyle(
                                  fontSize: 150.0,
                                  fontFamily: 'RussoOne',
                                  // color: colorsList[ansIndexList[((_random
                                  //             .nextInt(colorsList.length - 1)) +
                                  //         (_currAnsIndex + 1)) %
                                  //     (colorsList.length)]],
                                  color: questionType
                                      ? colorsList[ansIndexList[_currAnsIndex]]
                                      : colorsList[ansIndexList[
                                          _currinterferenceOptionIndex]],
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
                  questionType: questionType,
                  btn1ListString: wordsList[optionsIndexList[0]],
                  btn2ListString: wordsList[optionsIndexList[1]],
                  buttonBackgroundColor1: questionType
                      ? Colors.white
                      : colorsList[optionsIndexList[0]],
                  buttonBackgroundColor2: questionType
                      ? Colors.white
                      : colorsList[optionsIndexList[1]],
                  updatestate: (String userAns) {
                    setState(() {
                      checkAnswer(userAns, questionType, context);
                    });
                  }),
              const SizedBox(height: 5.0),

              /// Answer row 2
              genrow(
                  btn1: 2,
                  btn2: 3,
                  questionType: questionType,
                  btn1ListString: wordsList[optionsIndexList[2]],
                  btn2ListString: wordsList[optionsIndexList[3]],
                  buttonBackgroundColor1: questionType
                      ? Colors.white
                      : colorsList[optionsIndexList[2]],
                  buttonBackgroundColor2: questionType
                      ? Colors.white
                      : colorsList[optionsIndexList[3]],
                  updatestate: (String userAns) {
                    setState(() {
                      checkAnswer(userAns, questionType, context);
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
