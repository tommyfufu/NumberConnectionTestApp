import 'package:flutter/material.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';
import 'package:number_connection_test/services/crud/sqlite/records_service.dart';
import 'package:number_connection_test/views/records_list_view.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({super.key});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late final RecordsService _recordsService;
  late final Services _services;
  var isLoaded = false;
  String get _userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _services = Services();
    _initializeToGetRecord();
    super.initState();
  }

  Future<void> _initializeToGetRecord() async {
    // print("$_userEmail");
    try {
      var user = await _services.getDatabaseUser(email: _userEmail);
      var dbRecord = await _services.createDatabaseRecord(
          owner: user, gameId: 0, gameTime: '100', score: 10);
      print(dbRecord.gameDateTime);
      setState(() {
        isLoaded = true;
      });
    } on DBCouldNotFindUser {
      print('cant find user');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遊戲紀錄'),
      ),
      extendBodyBehindAppBar: false,
      body: Text('testing'),
      // FutureBuilder(
      //   future: _recordsService.getOrCreateUser(email: _userEmail),
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.done:
      //         return StreamBuilder(
      //             stream: _recordsService.allRecords,
      //             builder: (context, snapshot) {
      //               switch (snapshot.connectionState) {
      //                 case ConnectionState.waiting:
      //                 case ConnectionState.active:
      //                   if (snapshot.hasData) {
      //                     final allRecords =
      //                         snapshot.data as List<DatabaseRecords>;
      //                     return RecordsListView(
      //                       records: allRecords,
      //                     );
      //                   } else {
      //                     return const CircularProgressIndicator();
      //                   }
      //                 default:
      //                   return const CircularProgressIndicator();
      //               }
      //             });
      //       default:
      //         return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // )
    );
  }
}
