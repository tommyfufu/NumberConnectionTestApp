import 'package:flutter/material.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/records_service.dart';
import 'package:number_connection_test/views/records_list_view.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({super.key});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late final RecordsService _recordsService;
  String get _userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _recordsService = RecordsService();
    // _recordsService.open(); we don't need this anymore, because we make sure
    // db will open at any RecordsService, aka _ensureDbIsOpen();
    super.initState();
  }

  @override
  void dispose() {
    // _recordsService.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('遊戲紀錄'),
        ),
        extendBodyBehindAppBar: false,
        body: FutureBuilder(
          future: _recordsService.getOrCreateUser(email: _userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                    stream: _recordsService.allRecords,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final allRecords =
                                snapshot.data as List<DatabaseRecords>;
                            return RecordsListView(
                              records: allRecords,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        default:
                          return const CircularProgressIndicator();
                      }
                    });
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
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