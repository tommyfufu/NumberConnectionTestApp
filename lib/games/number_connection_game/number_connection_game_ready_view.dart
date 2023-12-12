import 'package:flutter/material.dart';
import 'package:number_connection_test/games/number_connection_game/number_connection_game_view.dart';
import 'package:number_connection_test/utilities/dialogs/show_range_check_dialog.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberConnectionReadyView extends StatefulWidget {
  const NumberConnectionReadyView({
    super.key,
  });

  @override
  State<NumberConnectionReadyView> createState() =>
      _NumberConnectionReadyViewState();
}

class _NumberConnectionReadyViewState extends State<NumberConnectionReadyView> {
  int _startingNumber = 1;
  int _endingNumber = 1;

  @override
  Widget build(BuildContext context) {
    const double sizeboxWidth = 50.0;
    const double sizeboxHeigt = 20.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: Icon(Icons.arrow_back),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '數字',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            Text(
              '點點名',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: sizeboxHeigt),
            Text(
              '遊戲規則：\n螢幕上將出現隨機分布的數字\n請從起始數字開始\n將綠色按鈕長按成紅色\n按到結束數字時遊戲結束',
              style: GoogleFonts.permanentMarker(
                fontSize: 20,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
              textScaleFactor: 1,
            ),
            const SizedBox(height: sizeboxHeigt),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      '起始數字',
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
                          left: BorderSide(
                              width: 2.0, color: Colors.grey.shade400),
                          right: BorderSide(
                              width: 2.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: sizeboxWidth),
                Column(
                  children: [
                    Text(
                      '結束數字',
                      style: GoogleFonts.permanentMarker(fontSize: 18),
                      textScaleFactor: 1.5,
                    ),
                    NumberPicker(
                      value: _endingNumber,
                      itemWidth: 60,
                      minValue: 1,
                      maxValue: 50,
                      onChanged: (value) =>
                          setState(() => _endingNumber = value),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              width: 2.0, color: Colors.grey.shade400),
                          right: BorderSide(
                              width: 2.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 100),
                minimumSize: const Size(180, 80),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
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
                      builder: (context) => NumberConnectionGameView(
                            startNum: _startingNumber,
                            endNum: _endingNumber,
                          )));
                }
              },
              child: Text(
                '開始遊戲',
                style: GoogleFonts.permanentMarker(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
