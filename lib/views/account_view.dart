import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/mywidgets/texteditor.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late DatabaseUser thisAppUser;
  var isLoaded = false;

  @override
  void initState() {
    thisAppUser = Services().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('會員專區'),
        actions: <Widget>[
          IconButton.outlined(
            onPressed: () async {
              Services().logOut();

              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('E-mail: ${thisAppUser.email}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextEditorWidget(text: thisAppUser.name),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
            Text('Identity: ${thisAppUser.identity}'),
          ],
        ),
      ),
    );
  }
}
