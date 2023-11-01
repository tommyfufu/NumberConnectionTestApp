import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_connection_test/game/buttons_view.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/records_service.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.startNum, required this.endNum});
  final int startNum;
  final int endNum;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  DatabaseRecords? _record;
  late final RecordsService _recordsService;
  late final _now = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now());
  late final String _gametime;
  final stopwatch = Stopwatch();
  bool gameStart = true;
  bool startStringPopUp = true;
  List<String> countDownAnimationString = [
    'Start',
    '1',
    '2',
    '3',
  ];

  @override
  void initState() {
    _recordsService = RecordsService();
    stopwatch.start();
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
    // _record = await _recordsService.updateRecord(
    //     record: newRecord, timestamp: nowTime, gametime: _gametime.toDouble());
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
            )),
      ),
    );
  }
}
