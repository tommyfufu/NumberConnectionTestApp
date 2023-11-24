import 'package:flutter/material.dart';

Expanded genrow(
    {required int btn1,
    required int btn2,
    required String btn1ListString,
    required String btn2ListString,
    required void Function(String) updatestate}) {
  return Expanded(
    flex: 2,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: genbutton(
                btnNum: btn1, btnStr: btn1ListString, updatestate: updatestate),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: genbutton(
                btnNum: btn2, btnStr: btn2ListString, updatestate: updatestate),
          ),
        ],
      ),
    ),
  );
}

ElevatedButton genbutton(
    {required int btnNum,
    required String btnStr,
    required void Function(String) updatestate}) {
  return ElevatedButton(
    onPressed: () {
      String userAns = btnStr;
      updatestate(userAns);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent[100],
      side: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
        color: Colors.black,
      ),
    ),
    child: Text(
      btnStr,
      style: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'KGB',
        // fontWeight: FontWeight.bold,
      ),
    ),
  );
}
