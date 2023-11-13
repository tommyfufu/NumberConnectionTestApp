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

  List<Offset> buttonPositions = [];

  @override
  void initState() {
    _recordsService = RecordsService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buttonPositions = generateButtonPositions(context);
      setState(() {});
    });
    stopwatch.start();
    super.initState();
  }

  List<Offset> generateButtonPositions(BuildContext context) {
    final List<Offset> positions = [];
    final Random random = Random();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = 300;
    // final double screenHeight = 700;

    // print(
    //     'MediaQuery.of(context).size.width: ${MediaQuery.of(context).size.width}');
    // print(
    //     'MediaQuery.of(context).size.height: ${MediaQuery.of(context).size.height}');
    int totalButtons = (widget.endNum - widget.startNum) + 1;
    for (int i = 0; i < totalButtons; i++) {
      Offset position;
      bool isTooClose;
      do {
        // Generate a random position within the screen boundaries
        position = Offset(
          (random.nextDouble() * screenWidth) % (screenWidth - 60),
          (random.nextDouble() * screenHeight) % (screenHeight - 140),
        );
        isTooClose = isPositionTooClose(position, positions);
      } while (isTooClose);

      positions.add(position);
      // print('position = $position');
    }

    if (positions.length < totalButtons) {
      return generateButtonPositions(context);
    }

    return positions;
  }

  bool isPositionTooClose(Offset newPosition, List<Offset> existingPositions) {
    for (final Offset existingPosition in existingPositions) {
      final double distance = (newPosition - existingPosition).distance;
      if (distance < 80.0) {
        return true; // Too close
      }
    }
    return false;
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
    gamingNumber = widget.startNum - 1;

    return Center(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 255, 240, 219),
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBody: false,
        body: Stack(children: [
          for (int i = 0; i < (widget.endNum - widget.startNum + 1); i++)
            Positioned(
              left: buttonPositions[i].dx,
              top: buttonPositions[i].dy,
              child: WrapperButton(
                labelnum: widget.startNum + i,
                endnum: widget.endNum,
                postiions: buttonPositions,
              ),
            ),
        ]),
      ),
    );
  }
}
