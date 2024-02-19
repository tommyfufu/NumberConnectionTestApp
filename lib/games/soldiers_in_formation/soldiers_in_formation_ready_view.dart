import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_connection_test/games/soldiers_in_formation/soldiers_in_formation_game_view.dart';

class SoldiersInFormationGameReadyView extends StatefulWidget {
  const SoldiersInFormationGameReadyView({
    super.key,
  });

  @override
  State<SoldiersInFormationGameReadyView> createState() =>
      _SoldiersInFormationGameReadyViewState();
}

class _SoldiersInFormationGameReadyViewState
    extends State<SoldiersInFormationGameReadyView> {
  @override
  Widget build(BuildContext context) {
    const double sizeboxHeigt = 20.0;
    const double sizeboxWidth = 20.0;
    double gridWidth = MediaQuery.of(context).size.width * 0.5;
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '按鈕',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            Text(
              '排排站',
              style: GoogleFonts.permanentMarker(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: sizeboxHeigt),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '遊戲玩法：',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '請快速的依照由左至右\n由上而下的順序',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
                Text(
                  '將綠色按鈕點擊成紅色',
                  style: GoogleFonts.permanentMarker(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                ),
              ],
            ),
            const SizedBox(height: sizeboxHeigt),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                maximumSize: const Size(200, 100),
                minimumSize: const Size(180, 80),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SoldiersInFormationGame()));
              },
              child: Text(
                '遊戲開始',
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
