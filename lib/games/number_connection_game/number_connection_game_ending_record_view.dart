import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';

class NCEndingRecordView extends StatefulWidget {
  const NCEndingRecordView({super.key, required this.record});
  final DatabaseRecord record;

  @override
  State<NCEndingRecordView> createState() => _NCEndingRecordViewState();
}

class _NCEndingRecordViewState extends State<NCEndingRecordView> {
  @override
  Widget build(BuildContext context) {
    const double sizeboxHeigt = 40.0;
    const TextStyle dataTextStyle = TextStyle(fontSize: 20);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '數字點點名',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
              ),
            ),
            const Text(
              '遊戲結束',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: sizeboxHeigt,
            ),
            const Text(
              '遊戲數據',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(
              width: 220,
              height: 10,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Table(
              columnWidths: const {
                0: FractionColumnWidth(0.5), // Adjust these widths as needed
                1: FractionColumnWidth(0.5),
              },
              children: [
                TableRow(
                  children: [
                    const Text(
                      '遊玩日期：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      widget.record.gameDateTime.split(" ")[0],
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      '遊玩時間：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      widget.record.gameDateTime.split(" ")[1],
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      '遊玩時長：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      widget.record.gameTime,
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      '按鈕總數：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      ' $globButtonsCount',
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      '按錯次數：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      ' $globWrongPressedCount',
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      '遊玩分數：',
                      style: dataTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      ' ${globButtonsCount - globWrongPressedCount}',
                      style: dataTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 220,
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    backgroundColor: globColor,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (_) => false,
                    );
                  },
                  child: Text(
                    '遊戲選單',
                    style: GoogleFonts.permanentMarker(fontSize: 18),
                    textScaleFactor: 1.5,
                  ),
                ),
                const SizedBox(
                  width: 20,
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    backgroundColor: globColor,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      numberConnectionReadyRoute,
                      (_) => false,
                    );
                  },
                  child: Text(
                    '再來一次',
                    style: GoogleFonts.permanentMarker(fontSize: 18),
                    textScaleFactor: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
