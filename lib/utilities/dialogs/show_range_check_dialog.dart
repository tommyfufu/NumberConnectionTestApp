import 'package:flutter/material.dart';
import 'package:number_connection_test/utilities/dialogs/generic_dialog.dart';

Future<bool> showRangeCheckingDialog(BuildContext context,
    {required String startingnum, required String endingnum}) {
  if (int.parse(startingnum) >= int.parse(endingnum)) {
    return showGenericDialog<bool>(
      context: context,
      title: 'Range Error',
      content: 'Starting Number must be smaller than Ending Number',
      optionsBuilder: () => {
        'OK': false,
      },
    ).then(
      (value) => value ?? false,
    );
  }
  return showGenericDialog<bool>(
    context: context,
    title: 'Range',
    content: 'Starting Number: $startingnum\nEnding Number: $endingnum',
    optionsBuilder: () => {
      'Reset': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
