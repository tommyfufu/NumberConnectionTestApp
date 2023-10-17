import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';

class GamesHomeView extends StatefulWidget {
  const GamesHomeView({super.key});

  @override
  State<GamesHomeView> createState() => _GamesHomeViewState();
}

class _GamesHomeViewState extends State<GamesHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(gameRouteReady);
              },
              child: const Text(
                '數字點點名',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(gameRouteReady);
              },
              child: const Text(
                '五顏配六色',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
