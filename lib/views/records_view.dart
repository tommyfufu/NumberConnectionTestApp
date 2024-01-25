import 'package:flutter/material.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/views/records_list_view.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({super.key});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late final Services _services;

  @override
  void initState() {
    _services = Services();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遊戲紀錄'),
      ),
      extendBodyBehindAppBar: false,
      body: FutureBuilder<Iterable<DatabaseRecord>>(
        future: _services.getAllRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final allRecords = snapshot.data as List<DatabaseRecord>;
            return RecordsListView(records: allRecords);
          } else {
            // Handle the case where there's no data
            return const Center(child: Text('No records found.'));
          }
        },
      ),
    );
  }
}
