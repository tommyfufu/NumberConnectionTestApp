import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';

import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/utilities/dialogs/logout_dialog.dart';
import 'package:number_connection_test/views/account_view/asus_vivowatch_data_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<DatabaseUser> _userFuture;
  late String _userEmail;
  late Services _services;

  @override
  void initState() {
    _services = Services();
    _userEmail = AuthService.firebase().currentUser!.email;
    _userFuture = Future(() => _services.getDatabaseUser(email: _userEmail));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final futureBuilderKey = ValueKey(_userEmail);
    return Scaffold(
        appBar: AppBar(
          title: const Text('會員專區'),
          toolbarHeight: 60.h,
          backgroundColor: globColor,
          actions: <Widget>[
            IconButton.outlined(
              onPressed: () async {
                final shouldLogOut = await showLogOutDialog(context);
                // Check the user's decision
                if (shouldLogOut) {
                  await _services.logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (_) => false,
                  );
                }
              },
              icon: Icon(
                Icons.logout,
                size: 20.sp,
              ),
            ),
          ],
        ),
        body: FutureBuilder<DatabaseUser>(
          key: futureBuilderKey,
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
                                  enableInteractiveSelection: false,
                                  initialValue: user.name,
                                  decoration: const InputDecoration(
                                    labelText: '姓名',
                                    // labelStyle: TextStyle(
                                    //   fontSize: 25, // Set your desired size
                                    // ),
                                  ),
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 28,
                                    color:
                                        globFontColor, // Adjust the font size as needed
                                  ),
                                ),
                                TextFormField(
                                  enableInteractiveSelection: false,
                                  initialValue: user.gender,
                                  decoration: const InputDecoration(
                                    labelText: '性別',
                                    // labelStyle: TextStyle(
                                    //   fontSize: 25, // Set your desired size
                                    // ),
                                  ),
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 28,
                                    color:
                                        globFontColor, // Adjust the font size as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Space between rows
                      TextFormField(
                        enableInteractiveSelection: false,
                        initialValue: user.email,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          // labelStyle: TextStyle(
                          //   fontSize: 25, // Set your desired size
                          // ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 26,
                          color:
                              globFontColor, // Adjust the font size as needed
                        ),
                      ),
                      TextFormField(
                        initialValue: user.identity,
                        enableInteractiveSelection: false,
                        decoration: const InputDecoration(
                          labelText: '身份',
                          // labelStyle: TextStyle(
                          //   fontSize: 25,
                          // ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 28,
                          color:
                              globFontColor, // Adjust the font size as needed
                        ),
                      ),
                      TextFormField(
                        initialValue: user.birthday,
                        enableInteractiveSelection: false,
                        decoration: const InputDecoration(
                          labelText: '生日',
                          // labelStyle: TextStyle(
                          //   fontSize: 25, // Set your desired size
                          // ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 28,
                          color:
                              globFontColor, // Adjust the font size as needed
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(140.w, 120.h),
                              minimumSize: Size(120.w, 100.h),
                              // backgroundColor: const Color.fromARGB(255, 27, 97, 149),
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              // padding: EdgeInsets.all(20),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ASUSVivoWatchDataView()));
                            },
                            child: Text(
                              '用藥\n紀錄',
                              style: TextStyle(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold,
                                color: globColor,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(140.w, 120.h),
                              minimumSize: Size(120.w, 100.h),
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  // color: Colors.black,
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ASUSVivoWatchDataView()));
                            },
                            child: Text(
                              '手錶\n資料',
                              style: TextStyle(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold,
                                color: globColor,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                        ],
                      ),
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
