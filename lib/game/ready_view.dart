import 'package:flutter/material.dart';
import 'package:number_connection_test/game/game_view.dart';
import 'package:number_connection_test/utilities/dialogs/show_range_check_dialog.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadyView extends StatefulWidget {
  const ReadyView({
    super.key,
  });

  @override
  State<ReadyView> createState() => _ReadyViewState();
}

class _ReadyViewState extends State<ReadyView> {
  int _startingNumber = 1;
  int _endingNumber = 1;

  @override
  Widget build(BuildContext context) {
    const double sizeboxWidth = 50.0;
    const double sizeboxHeigt = 30.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: Icon(Icons.arrow_back),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Game',
            style: GoogleFonts.permanentMarker(fontSize: 36),
            textScaleFactor: 1.5,
          ),
          Text(
            'Connection',
            style: GoogleFonts.permanentMarker(fontSize: 36),
            textScaleFactor: 1.5,
          ),
          const SizedBox(height: sizeboxHeigt),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Start',
                    style: GoogleFonts.permanentMarker(fontSize: 18),
                    textScaleFactor: 1.5,
                  ),
                  NumberPicker(
                    value: _startingNumber,
                    itemWidth: 60,
                    minValue: 1,
                    maxValue: 50,
                    haptics: true,
                    onChanged: (value) =>
                        setState(() => _startingNumber = value),
                    decoration: BoxDecoration(
                      border: Border(
                        left:
                            BorderSide(width: 2.0, color: Colors.grey.shade400),
                        right:
                            BorderSide(width: 2.0, color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: sizeboxWidth),
              Column(
                children: [
                  Text(
                    'End',
                    style: GoogleFonts.permanentMarker(fontSize: 18),
                    textScaleFactor: 1.5,
                  ),
                  NumberPicker(
                    value: _endingNumber,
                    itemWidth: 60,
                    minValue: 1,
                    maxValue: 50,
                    onChanged: (value) => setState(() => _endingNumber = value),
                    decoration: BoxDecoration(
                      border: Border(
                        left:
                            BorderSide(width: 2.0, color: Colors.grey.shade400),
                        right:
                            BorderSide(width: 2.0, color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(140, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            onPressed: () async {
              final rangeOk = await showRangeCheckingDialog(
                context,
                startingnum: _startingNumber,
                endingnum: _endingNumber,
              );
              if (rangeOk) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GameView(
                          startNum: _startingNumber,
                          endNum: _endingNumber,
                        )));
              }
            },
            child: Text(
              'Play',
              style: GoogleFonts.permanentMarker(fontSize: 25),
              textScaleFactor: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
