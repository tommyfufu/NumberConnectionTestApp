import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';

import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/views/asus_vivowatch_data_view.dart';

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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 70, // Adjust the radius as needed
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwM5DeX5IzxdcfTTbDO1J_P7jBnUZIini9gg&usqp=CAU'),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                              width: 20), // Space between image and text fields
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: user.name,
                                  decoration: const InputDecoration(
                                    labelText: '姓名',
                                    labelStyle: TextStyle(
                                      fontSize: 25, // Set your desired size
                                    ),
                                  ),
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize:
                                        28, // Adjust the font size as needed
                                  ),
                                ),
                                TextFormField(
                                  initialValue: user.gender,
                                  decoration: const InputDecoration(
                                    labelText: '性別',
                                    labelStyle: TextStyle(
                                      fontSize: 25, // Set your desired size
                                    ),
                                  ),
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize:
                                        28, // Adjust the font size as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Space between rows
                      TextFormField(
                        initialValue: user.email,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            fontSize: 25, // Set your desired size
                          ),
                        ),
                        readOnly: true,
                        style: const TextStyle(
                          fontSize: 26, // Adjust the font size as needed
                        ),
                      ),
                      TextFormField(
                        initialValue: user.identity,
                        decoration: const InputDecoration(
                          labelText: '身份',
                          labelStyle: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        readOnly: true,
                        style: const TextStyle(
                          fontSize: 28, // Adjust the font size as needed
                        ),
                      ),
                      TextFormField(
                        initialValue: user.birthday,
                        decoration: const InputDecoration(
                          labelText: '生日',
                          labelStyle: TextStyle(
                            fontSize: 25, // Set your desired size
                          ),
                        ),
                        readOnly: true,
                        style: const TextStyle(
                          fontSize: 28, // Adjust the font size as needed
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ASUSVivoWatchDataView()));
                          },
                          child: const Text(
                            'ASUS VivoWatch 資料',
                            style: TextStyle(fontSize: 25),
                          )),
                    ],
                  ),
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
