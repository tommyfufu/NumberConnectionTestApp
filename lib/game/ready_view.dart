import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/game/board_setting.dart';
import 'package:number_connection_test/game/game_view.dart';
import 'package:number_connection_test/utilities/dialogs/show_range_check_dialog.dart';

class ReadyView extends StatefulWidget {
  const ReadyView({
    super.key,
  });

  @override
  State<ReadyView> createState() => _ReadyViewState();
}

class _ReadyViewState extends State<ReadyView> {
  late final TextEditingController startingnumberController;
  late final TextEditingController endingnumberController;

  @override
  void initState() {
    startingnumberController = TextEditingController();
    endingnumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    startingnumberController.dispose();
    endingnumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Number Connection'),
      ),
      body: Column(children: [
        TextField(
          controller: startingnumberController,
          enableSuggestions: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Please Enter Strating Number',
          ),
        ),
        TextField(
          controller: endingnumberController,
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
                startingnum: startingnumberController.text,
                endingnum: endingnumberController.text,
              );
              if (rangeOk) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GameView(
                          startNum: int.parse(startingnumberController.text),
                          endNum: int.parse(endingnumberController.text),
                        )));
              }
            },
            child: const Text('Confirm'))
      ]),
    );
  }
}
