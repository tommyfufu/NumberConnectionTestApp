import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_connection_test/constants/routes.dart';

class CWGameOverView extends StatelessWidget {
  const CWGameOverView({
    super.key,
    required this.finishedTime,
    required this.gameScore,
  });
  final String finishedTime;
  final int gameScore;
  @override
  Widget build(BuildContext context) {
    const double sizeboxWidth = 50.0;
    const double sizeboxHeigt = 40.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '遊戲結束',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 60,
              ),
            ),
            const SizedBox(height: sizeboxHeigt),
            Text(
              '完成時間: $finishedTime\n答對題數: $gameScore',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '積分榜',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              width: 220,
              height: 10,
              child: Divider(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.looks_one_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.looks_two_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '6',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.looks_3_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '5',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: sizeboxWidth),
                ],
              ),
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
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      colorVsWordsGameRoute,
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
