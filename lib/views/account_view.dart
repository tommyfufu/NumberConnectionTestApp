import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';

import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late final Future<DatabaseUser> _userFuture;
  late final String _userEmail;
  final _services = Services();

  @override
  void initState() {
    _userEmail = AuthService.firebase().currentUser!.email;
    _userFuture = _services.getDatabaseUser(email: _userEmail);
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
        body: FutureBuilder<DatabaseUser>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle error state
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('E-mail: ${user.email}'),
                    Text('Name: ${user.name}'),
                    Text('Identity: ${user.identity}'),
                  ],
                ),
              );
            } else {
              // Handle the case where snapshot.data is null
              return const Center(child: Text('No user data available.'));
            }
          },
        ));
  }
}
