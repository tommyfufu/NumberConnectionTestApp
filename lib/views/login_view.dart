//login View

import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/auth/auth_exceptions.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';
import 'package:number_connection_test/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const uiHight = 20.0;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('登入'),
        // ),
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'HE App',
                style: TextStyle(
                  color: globColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  // fontFamily:
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: '請輸入您的e-mail',
                  icon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: uiHight,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: '請輸入您的密碼',
                  icon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(
                height: uiHight,
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await Services().getDatabaseUser(email: email);
                    try {
                      await AuthService.firebase().logIn(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        //user's email is verified
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          homeRoute,
                          (route) => false,
                        );
                      } else {
                        //user's email is NOT verified
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    } on WrongPasswordOrUserNotFoundAuthException {
                      await showErrorDialog(
                        context,
                        '用戶問題',
                        '找不到輸入的用戶或輸入的密碼錯誤',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                        '用戶問題',
                        '輸入的Email格式錯誤',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        '驗證問題',
                        '驗證問題',
                      );
                    }
                  } on DBCouldNotFindUser {
                    await showErrorDialog(
                        context, 'Database', 'Can Not find user');
                  } on DatabaseIsNotOpen {
                    await showErrorDialog(context, 'Database', 'Did not open');
                  }
                },
                child: const Text(
                  '登入',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: globColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text(
                  '點擊此處註冊',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: globColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
