import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  final int? startnum;
  final int? endnum;

  const GameView({
    super.key,
    this.startnum,
    this.endnum,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect the numbers in order')),
      // body: [];
    );
  }
}
