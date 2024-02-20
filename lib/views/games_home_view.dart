import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';

class GamesHomeView extends StatefulWidget {
  const GamesHomeView({super.key});

  @override
  State<GamesHomeView> createState() => _GamesHomeViewState();
}

class _GamesHomeViewState extends State<GamesHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: Icon(Icons.arrow_back),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '遊戲選單',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(260, 100),
                minimumSize: const Size(200, 80),
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
              onPressed: () {
                Navigator.of(context).pushNamed(numberConnectionReadyRoute);
              },
              child: const Text(
                '數字點點名',
                style: TextStyle(
                  fontSize: 40,
                  color: globColor,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(260, 100),
                minimumSize: const Size(200, 80),
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
              onPressed: () {
                Navigator.of(context).pushNamed(colorVsWordsGameReadyRoute);
              },
              child: const Text(
                '五顏配六色',
                style: TextStyle(
                  fontSize: 40,
                  color: globColor,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(260, 100),
                minimumSize: const Size(200, 80),
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
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(soldiersInFormationGameReadyRoute);
              },
              child: const Text(
                '按鈕排排站',
                style: TextStyle(
                  fontSize: 40,
                  color: globColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
