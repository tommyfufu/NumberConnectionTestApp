import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_connection_test/game/ready_view.dart';
import 'package:number_connection_test/main.dart';

class GameOverView extends StatelessWidget {
  const GameOverView({super.key});

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
              'You Win!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
              ),
            ),
            const SizedBox(height: sizeboxHeigt),
            const Text(
              'Finish Time: 00:09',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: sizeboxHeigt,
            ),
            const Text(
              'Best Records',
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
                        children: [
                          Icon(
                            Icons.looks_one_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '00:09',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.looks_two_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '00:10',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.looks_3_outlined,
                            size: 40,
                          ),
                          SizedBox(width: sizeboxWidth),
                          Text(
                            '00:25',
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  child: Text(
                    'HOME',
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReadyView()));
                  },
                  child: Text(
                    'RESTART',
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
