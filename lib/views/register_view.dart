import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/services/auth/auth_exceptions.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/models/UsersAndRecords.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';
import 'package:number_connection_test/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _identity;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _identity = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _identity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(title: const Text('註冊')),
      body: Column(
        children: [
          //controller (like poxry ) connect to Textfield
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: '請輸入您的e-mail',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: '請輸入您的密碼',
            ),
          ),
          TextField(
            controller: _name,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: '請輸入您的大名',
            ),
          ),
          TextField(
            controller: _identity,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: '請輸入您的身分',
            ),
          ),
          //controller connect to TextButton
          TextButton(
            onPressed: () async {
              final localcontext = this.context;
              final email = _email.text;
              final password = _password.text;
              final name = _name.text;
              final identity = _identity.text;
              try {
                await Services().createDatabaseUser(
                  email: email,
                  name: name,
                  identity: identity,
                );
                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  await AuthService.firebase().sendEmailVerification();
                  Navigator.of(localcontext).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                } on WeakPasswordAuthException {
                  await showErrorDialog(localcontext, '密碼問題', '密碼強度太弱，請換一組密碼');
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(localcontext, 'Email問題', '此E-mail已被註冊');
                } on InvalidEmailAuthException {
                  await showErrorDialog(localcontext, 'Email問題', '此E-mail格式有誤');
                } on GenericAuthException {
                  await showErrorDialog(localcontext, '出錯了', '註冊失敗');
                }
              } on DBCouldNotCreateUser {
                await showErrorDialog(
                    localcontext, 'Database', 'Create user failed');
              } on DBUserAlreadyExists {
                await showErrorDialog(
                    localcontext, 'Database', 'User already exsit');
              } on DatabaseIsNotOpen {
                await showErrorDialog(
                    localcontext, 'Database', 'Database not open');
              }
            },
            child: const Text('註冊'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text('已經註冊了嗎？點擊這裡登入！'),
          )
        ],
      ),
    );
  }
}
