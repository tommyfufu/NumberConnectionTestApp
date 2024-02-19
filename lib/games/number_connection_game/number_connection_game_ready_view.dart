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
              '數字點點名',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: sizeboxHeigt),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '普通模式：',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 120, 169, 140),
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
                const SizedBox(height: sizeboxHeigt),
                Text(
                  '進階模式：',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 120, 169, 140),
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
            Text(
              '選擇模式',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textScaleFactor: 1,
            ),
            const SizedBox(height: sizeboxHeigt),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(140, 120),
                    minimumSize: const Size(120, 100),
                    // backgroundColor: const Color.fromARGB(255, 27, 97, 149),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    // padding: EdgeInsets.all(20),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NumberConnectionSteadyView(
                              mode: false,
                            )));
                  },
                  child: Text(
                    '普通\n模式',
                    style: GoogleFonts.permanentMarker(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 120, 169, 140),
                    ),
                    textScaleFactor: 1,
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(140, 120),
                    minimumSize: const Size(120, 100),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        // color: Colors.black,
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NumberConnectionSteadyView(
                              mode: true,
                            )));
                  },
                  child: Text(
                    '進階\n模式',
                    style: GoogleFonts.permanentMarker(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 120, 169, 140),
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
