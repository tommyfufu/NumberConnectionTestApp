import 'package:flutter/material.dart';

class WrapperButton extends StatefulWidget {
  const WrapperButton({super.key, required this.labelnum});
  final int labelnum;
  @override
  State<WrapperButton> createState() => _WrapperButtonState();
}

class _WrapperButtonState extends State<WrapperButton> {
  // var _pressedFlag = {'notPressed': 0, 'firstPressed':1, 'pressAgain':2 };
  bool _pressedFlag = false;

  void _changeButtonState() {
    if (_pressedFlag) {
      setState(() {
        _pressedFlag = true; //wrong push
      });
    } else {
      setState(() {
        _pressedFlag = !_pressedFlag;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          child: FilledButton(
        style: FilledButton.styleFrom(
          alignment: const Alignment(0.0, 0.0),
          shape: const CircleBorder(),
          // padding: const EdgeInsets.all(15.0),
          backgroundColor: _pressedFlag ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
          side: _pressedFlag
              ? const BorderSide(color: Colors.red, width: 1.0)
              : const BorderSide(color: Colors.green, width: 1.0),
          // minimumSize: const Size(10, 10),
          // maximumSize: const Size(50, 50),
          // textStyle: const TextStyle(fontSize: 11, fontStyle: FontStyle.normal),
          // disabledBackgroundColor: Colors.red,
          // disabledForegroundColor: Colors.white,
        ),

        // child: const SizedBox.shrink(),
        onPressed: () {},
        onLongPress: _changeButtonState,
        child: Text(
          widget.labelnum.toString(),
        ),
      )),
    );
  }
}
