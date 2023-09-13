import 'package:flutter/material.dart';
import 'package:number_connection_test/utilities/dialogs/show_range_check_dialog.dart';

class ReadyView extends StatefulWidget {
  const ReadyView({super.key});

  @override
  State<ReadyView> createState() => _ReadyViewState();
}

class _ReadyViewState extends State<ReadyView> {
  late final TextEditingController starting_number;
  late final TextEditingController ending_number;

  @override
  void initState() {
    starting_number = TextEditingController();
    ending_number = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    starting_number.dispose();
    ending_number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Connection'),
      ),
      body: Column(children: [
        TextField(
          controller: starting_number,
          enableSuggestions: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Please Enter Strating Number',
          ),
        ),
        TextField(
          controller: ending_number,
          enableSuggestions: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Please Enter Ending Number',
          ),
        ),
        TextButton(
            onPressed: () async {
              final rangeOk = await showRangeCheckingDialog(
                context,
                startingnum: starting_number.text,
                endingnum: ending_number.text,
              );
              if (rangeOk) {
                Navigator.of(context).pushNamed('gameRouteStart', arguments: {
                  int.parse(starting_number.text),
                  int.parse(ending_number.text),
                }).then((value) {});
              }
            },
            child: const Text('Confirm'))
      ]),
    );
  }
}
