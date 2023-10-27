import 'package:flutter/material.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
    );
  }
}

// all body layout
// body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     // crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Best Records',
      //         style: TextStyle(
      //           fontSize: 30,
      //         ),
      //       ),
      //       SizedBox(
      //         width: 220,
      //         height: 10,
      //         child: Divider(
      //           color: Colors.black,
      //         ),
      //       ),
      //       SizedBox(
      //         width: 220,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Column(
      //               children: [
      //                 Row(
      //                   children: [
      //                     Icon(
      //                       Icons.looks_one_outlined,
      //                       size: 40,
      //                     ),
      //                     SizedBox(width: 50),
      //                     Text(
      //                       '00:09',
      //                       style: TextStyle(
      //                         fontSize: 25,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(
      //                   height: 20,
      //                 ),
      //                 Row(
      //                   children: [
      //                     Icon(
      //                       Icons.looks_two_outlined,
      //                       size: 40,
      //                     ),
      //                     SizedBox(width: 50),
      //                     Text(
      //                       '00:10',
      //                       style: TextStyle(
      //                         fontSize: 25,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(
      //                   height: 20,
      //                 ),
      //                 Row(
      //                   children: [
      //                     Icon(
      //                       Icons.looks_3_outlined,
      //                       size: 40,
      //                     ),
      //                     SizedBox(width: 50),
      //                     Text(
      //                       '00:25',
      //                       style: TextStyle(
      //                         fontSize: 25,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               width: 50,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),