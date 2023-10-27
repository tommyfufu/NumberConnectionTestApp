import 'package:flutter/material.dart';
import 'package:number_connection_test/services/crud/records_service.dart';
import 'package:number_connection_test/utilities/dialogs/delete_dialog.dart';

typedef RecordCallback = void Function(DatabaseRecords record);

class RecordsListView extends StatelessWidget {
  final List<DatabaseRecords> records;
  final RecordCallback onDeleteRecord;
  final RecordCallback onTap;

  const RecordsListView({
    Key? key,
    required this.records,
    required this.onDeleteRecord,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final note = records[index];
        return ListTile(
          onTap: () {
            onTap(note);
          },
          title: Text(
            note.gameTime.toString(),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteRecord(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
