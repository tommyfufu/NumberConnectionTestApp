import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/games/number_connection_game/gaming_exceptions.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/utilities/dialogs/error_dialog.dart';

class WrapperButton extends StatefulWidget {
  const WrapperButton({
    super.key,
    required this.labelnum,
    required this.endnum,
    required this.postiions,
  });
  final int labelnum;
  final int endnum;
  final List<Offset> postiions;
  @override
  State<WrapperButton> createState() => _WrapperButtonState();
}

class _WrapperButtonState extends State<WrapperButton> {
  bool _pressedFlag = false;

  @override
  void initState() {
    // print('Label Num = ${widget.labelnum}');
    super.initState();
  }

  void _changeButtonStateandCheckEnding(int nowValue, int endValue) {
    if (globGamingNumber == (nowValue - 1)) {
      setState(() {
        _pressedFlag = true;
        globGamingNumber = nowValue;
      });
      if (nowValue == endValue) {
        // game over
        Navigator.of(context)
            .pushNamedAndRemoveUntil(ncgameoverRoute, (_) => false);
      }
    } else {
      setState(() {
        _pressedFlag = _pressedFlag;
      });
      showErrorDialog(context, '阿喔錯了', '請按照按鈕上的數字順序點選按鈕喔');
      throw WrongOrderException();
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool makeBig = Random().nextBool();
    // Offset position = widget.postiions[widget.labelnum - 1];
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // alignment: const Alignment(0.0, 0.0),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10.0),
        backgroundColor: _pressedFlag ? Colors.red : Colors.green,
        foregroundColor: Colors.white,
        shadowColor: const Color.fromARGB(247, 186, 184, 184),
        textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          // wordSpacing: -1,
          fontWeight: FontWeight.bold,
        ),
        side: _pressedFlag
            ? const BorderSide(
                color: Colors.red,
              )
            : const BorderSide(
                color: Colors.green,
              ),
        // minimumSize: const Size(10, 10),
        maximumSize: const Size(100, 100),
        // textStyle: const TextStyle(fontSize: 11, fontStyle: FontStyle.normal),
        // disabledBackgroundColor: Colors.red,
        // disabledForegroundColor: Colors.white,
      ),
      onPressed: () {},
      onLongPress: () {
        _changeButtonStateandCheckEnding(
          widget.labelnum,
          widget.endnum,
        );
      },
      child: Text(
        widget.labelnum.toString(),
      ),
    );
  }
}
