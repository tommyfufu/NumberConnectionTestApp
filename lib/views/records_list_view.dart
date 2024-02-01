import 'package:flutter/material.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';

typedef RecordCallback = void Function(DatabaseRecord record);

class RecordsListView extends StatelessWidget {
  final List<DatabaseRecord> records;

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
        final gameId = record.gameId;
        final gameIdtoString = gameMap[gameId];
        final formattedTime = record.gameDateTime;
        return ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            '$formattedTime $gameIdtoString ${record.gameTime} ${record.score}',
            style: const TextStyle(fontSize: 18),
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
