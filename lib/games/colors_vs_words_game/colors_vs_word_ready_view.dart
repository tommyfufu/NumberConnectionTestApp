import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_connection_test/games/colors_vs_words_game/colorsvsword_game_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:numberpicker/numberpicker.dart';

class ColorsVsWordGameReadyView extends StatefulWidget {
  const ColorsVsWordGameReadyView({
    super.key,
  });

  @override
  State<ColorsVsWordGameReadyView> createState() =>
      _ColorsVsWordGameReadyViewState();
}

class _ColorsVsWordGameReadyViewState extends State<ColorsVsWordGameReadyView> {
  @override
  Widget build(BuildContext context) {
    const double sizeboxHeigt = 30.0;
    int _mode = 1;

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
              '五顏',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 1.5,
            ),
            Text(
              '配六色',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: 20),
            Text(
              '選擇模式',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 0.5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ColorvsWordGameView(
                          questionType: true,
                        )));
              },
              child: Text(
                '模式一',
                style: GoogleFonts.permanentMarker(fontSize: 25),
                textScaleFactor: 1.5,
              ),
            ),
            Text(
              '觀察題目中字的底色',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 0.6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ColorvsWordGameView(
                          questionType: false,
                        )));
              },
              child: Text(
                '模式二',
                style: GoogleFonts.permanentMarker(fontSize: 25),
                textScaleFactor: 1.5,
              ),
            ),
            Text(
              '根據題目中字的意義選出對應的顏色',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 0.6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ColorvsWordGameView(
                          questionType: false,
                        )));
              },
              child: Text(
                '模式三',
                style: GoogleFonts.permanentMarker(fontSize: 25),
                textScaleFactor: 1.5,
              ),
            ),
            Text(
              '隨機出題',
              style: GoogleFonts.permanentMarker(fontSize: 36),
              textScaleFactor: 0.6,
            ),
          ],
        ),
      ),
    );
  }
}
