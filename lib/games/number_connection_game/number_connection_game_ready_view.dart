import 'package:flutter/material.dart';
import 'package:number_connection_test/games/number_connection_game/number_connection_game_steady_view.dart';
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
  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '選擇遊戲模式',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 30,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '普通模式：',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 26,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '僅出現數字',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '進階模式：',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 26,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '英文字母來搗亂！別被騙了！',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
              ],
            ),
            const SizedBox(height: sizeboxHeigt),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 100),
                minimumSize: const Size(180, 80),
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NumberConnectionSteadyView(
                          mode: false,
                        )));
              },
              child: Text(
                '普通模式',
                style: GoogleFonts.permanentMarker(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.5,
              ),
            ),
            const SizedBox(height: sizeboxHeigt),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 100),
                minimumSize: const Size(180, 80),
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NumberConnectionSteadyView(
                          mode: true,
                        )));
              },
              child: Text(
                '進階模式',
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
