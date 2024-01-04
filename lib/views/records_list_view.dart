import 'package:flutter/material.dart';
import 'package:number_connection_test/services/crud/sqlite/records_service.dart';

typedef RecordCallback = void Function(DatabaseRecords record);

class RecordsListView extends StatelessWidget {
  final List<DatabaseRecords> records;

  const RecordsListView({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final reverseRecords = records.reversed.toList();
        final record = reverseRecords[index];
        return ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            '${record.playTimestamp}  ${record.gameTime}',
            style: const TextStyle(fontSize: 20),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
